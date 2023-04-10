defmodule Katzen.Components.Accordion do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  @configs %{
    base: "block",
    variants: %{},
    default_variants: %{},
    compound_variants: []
  }

  @doc """
  Renders ...

  ## Default styles:

  ```heex
  <.accordion class={Cvax.cx(["...", @class])}>...</.accordion>
  ```
  Uses [Cvax.cx/1](https://hexdocs.pm/cvax/Cvax.html#cx/1) to generate class string from almost any input

  ## Examples

    <.accordion>...</.accordion>

  ## Stories

  **[accordion stories](/#)**
  """

  attr(:class, :string, default: "", doc: "CSS classes")

  slot(:inner_block,
    required: true,
    doc: """
    TODO: write doc
    """
  )

  attr(:rest, :global,
    doc: """
    TODO: write doc
    """
  )

  attr(:accordion_id, :string)

  slot :item, required: true, doc: "CSS class for parent container" do
    attr(:title, :string)
  end

  @spec accordion(map) :: Phoenix.LiveView.Rendered.t()
  def accordion(assigns) do
    assigns =
      assign_new(assigns, :accordion_id, fn ->
        "accordion_#{Ecto.UUID.generate()}"
      end)

    ~H"""
    <div id={@accordion_id} class={@class} {@rest}>
      <%= for {item, index} <- Enum.with_index(@item) do %>
        <div
          phx-mounted={true}
          phx-click={js(@accordion_id, index)}
          data-index={index}
          class={Cvax.cx(["border-b", "dark:border-gray-700"])}
        >
          <button
            type="button"
            class={
              Cvax.cx([
                "block sm:flex items-center justify-between w-full py-5 text-left text-slate-800",
                "dark:text-slate-200",
                "flex flex-1 items-center justify-between py-4 font-medium transition-all hover:underline"
              ])
            }
          >
            <span class="text-base font-semibold">
              <%= item.title %>
            </span>

            <svg
              id={"icon-#{@accordion_id}-#{index}"}
              data-open={"#{index == 0}"}
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              class={
                Cvax.cx([
                  "flex-shrink-0 w-6 h-6 ml-3 duration-300 text-slate-400",
                  "dark:group-hover:text-slate-300 group-hover:text-slate-500",
                  "data-[open='true']:rotate-180"
                ])
              }
            >
              <polyline points="6 9 12 15 18 9"></polyline>
            </svg>
          </button>

          <div
            id={"content-#{@accordion_id}-#{index}"}
            class={"content-#{@accordion_id}" <> " " <> get_default_content_open_state(index == 0)}
          >
            <div class={
              # Cvax.cx([
              "pb-5 dark:border-gray-700 dark:bg-gray-900"
              # ])
            }>
              <%= render_slot(item) %>
            </div>
          </div>
        </div>
      <% end %>
    </div>
    """
  end

  def js(accordion_id, index, js \\ %JS{}) do
    js
    |> JS.add_class("hidden", to: ".content-#{accordion_id}")
    |> JS.remove_class("hidden", to: "#content-#{accordion_id}-#{index}")
    |> JS.add_class("block", to: "#content-#{accordion_id}-#{index}")
    |> JS.set_attribute({"data-open", "false"}, to: "[data-open='true']")
    |> JS.set_attribute({"data-open", "true"}, to: "#icon-#{accordion_id}-#{index}")
  end

  @spec get_default_content_open_state(opened :: boolean()) :: String.t()
  def get_default_content_open_state(opened) do
    if opened, do: "block", else: "hidden"
  end
end
