defmodule Mix.Tasks.Phx.Gen.Component do
  @shortdoc "Generates a LiveView components"

  @moduledoc """
  Generates LiveView components

  ```bash
  $> mix phx.gen.component Button --tag button
  ```

  The generated files will contain:

    * a component file in `lib/my_app_web/components/component_name.ex`
    * a story file in `storybook/components/component_name.story.exs`
    * a test file in `test/components/component_name_test.exs`
  """

  use Mix.Task

  @requirements ["app.config"]
  @templates_folder "priv/templates/phx.gen.component"
  @switches [tag: :string]

  @doc false
  def run(argv) do
    [opts, component_name] = parse_opts(argv)

    web_module = web_module()
    core_components_module = Module.concat([web_module, :Components])
    app_name = String.to_atom(Macro.underscore(web_module))
    # app_folder = Path.join("lib", to_string(app_name))
    components_folder = "katzen_components"
    # web_module_name = Module.split(web_module) |> List.last()
    # js_folder = "assets/js"
    # css_folder = "assets/css"
    # file_name = Macro.underscore(component_name)

    context = %{
      app: app_name,
      component_name: Module.concat([component_name]),
      function_name: Macro.underscore(component_name),
      tag_name: Keyword.get(opts, :tag, "div"),
      components_module: core_components_module,
      # web_module
      module: "Katzen"
    }

    mapping = [
      {"component.ex.eex",
       Path.join(["lib", components_folder, Macro.underscore(component_name) <> ".ex"])},
      {"story.exs.eex",
       Path.join(["storybook", Macro.underscore(component_name) <> ".story.exs"])},
      {"test.exs.eex",
       Path.join(["test/components", Macro.underscore(component_name) <> "_test.exs"])}
    ]

    for {source_file_path, target} <- mapping do
      # templates_folder = Application.app_dir(:my_app_name, @templates_folder)
      templates_folder = Path.join("", @templates_folder)

      source = Path.join(templates_folder, source_file_path)

      source_content =
        case Path.extname(source) do
          ".eex" -> EEx.eval_file(source, context: context)
          _ -> File.read!(source)
        end

      Mix.Generator.create_file(target, source_content)
    end
  end

  defp parse_opts(argv) do
    case OptionParser.parse(argv, strict: @switches) do
      {opts, [component_name], []} ->
        [opts, component_name]

      {_opts, [argv | _], _} ->
        Mix.raise("Invalid option: #{argv}")

      {_opts, _argv, [switch | _]} ->
        Mix.raise("Invalid option: " <> switch_to_string(switch))
    end
  end

  defp switch_to_string({name, nil}), do: name
  defp switch_to_string({name, val}), do: name <> "=" <> val

  defp web_module do
    base = Mix.Phoenix.base()

    cond do
      Mix.Phoenix.context_app() != Mix.Phoenix.otp_app() -> Module.concat([base])
      String.ends_with?(base, "Web") -> Module.concat([base])
      true -> Module.concat(["#{base}Web"])
    end
  end
end
