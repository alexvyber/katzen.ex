defmodule Katzen.Components.Modal do
  use Phoenix.Component
  alias Phoenix.LiveView.JS
  import KatzenWeb.Gettext

  # @configs %{
  #   base: "",
  #   variants: %{},
  #   default_variants: %{},
  #   compound_variants: []
  # }

  # @doc """
  # Renders ...

  # ## Default styles:

  # ```heex
  # <.modal class={Cvax.cx(["...", @class])}>...</.modal>
  # ```
  # Uses [Cvax.cx/1](https://hexdocs.pm/cvax/Cvax.html#cx/1) to generate class string from almost any input

  # ## Examples

  #   <.modal>...</.modal>

  # ## Stories

  # **[modal stories](/#)**
  # """

  @doc """
  Renders a modal.

  ## Examples

      <.modal id="confirm-modal">
        This is a modal.
      </.modal>

  JS commands may be passed to the `:on_cancel` to configure
  the closing/cancel event, for example:

      <.modal id="confirm" on_cancel={JS.navigate(~p"/posts")}>
        This is another modal.
      </.modal>

  """

  attr(:id, :string, required: true)
  attr :show, :boolean, default: false
  attr :on_cancel, JS, default: %JS{}
  slot :inner_block, required: true

  attr(:size, :string,
    default: "lg",
    values: ["xs", "sm", "md", "lg", "xl", "2xl", "3xl", "4xl", "5xl", "6xl", "7xl", "full"],
    doc: "modal size"
  )

  attr(:class, :string, default: "", doc: "CSS classes")

  attr(:rest, :global,
    doc: """
    TODO: write doc
    """
  )

  @spec modal(map) :: Phoenix.LiveView.Rendered.t()
  def modal(assigns) do
    assigns =
      assign(assigns, :max_width, %{
        "xs" => "max-w-xs",
        "sm" => "max-w-sm",
        "md" => "max-w-md",
        "lg" => "max-w-lg",
        "xl" => "max-w-xl",
        "2xl" => "max-w-2xl",
        "3xl" => "max-w-3xl",
        "4xl" => "max-w-4xl",
        "5xl" => "max-w-5xl",
        "6xl" => "max-w-6xl",
        "7xl" => "max-w-7xl",
        "full" => "max-w-full"
      })

    ~H"""
    <div
      id={@id}
      phx-mounted={@show && show_modal(@id)}
      phx-remove={hide_modal(@id)}
      data-cancel={JS.exec(@on_cancel, "phx-remove")}
      class="hidden relative z-50"
    >
      <div
        id={"#{@id}-bg"}
        class="fixed inset-0 transition-opacity bg-black/50 backdrop-blur-sm"
        aria-hidden="true"
      />
      <div
        class="overflow-y-auto fixed inset-0"
        aria-labelledby={"#{@id}-title"}
        aria-describedby={"#{@id}-description"}
        role="dialog"
        aria-modal="true"
        tabindex="0"
      >
        <div class="flex justify-center items-start min-h-full sm:items-center">
          <div class={Cvax.cx([" w-full sm:p-6 lg:py-8", Map.get(@max_width, @size, "max-w-3xl")])}>
            <%!-- shadow-lg ring-1 shadow-zinc-700/10 ring-zinc-700/10 --%>
            <.focus_wrap
              id={"#{@id}-container"}
              phx-window-keydown={JS.exec("data-cancel", to: "##{@id}")}
              phx-key="escape"
              phx-click-away={JS.exec("data-cancel", to: "##{@id}")}
              class="hidden relative p-6 bg-white transition sm:rounded-xl dark:bg-slate-700"
            >
              <div class="absolute right-5 top-6">
                <button
                  phx-click={JS.exec("data-cancel", to: "##{@id}")}
                  type="button"
                  class="flex-none p-3 -m-3 opacity-30 hover:opacity-60"
                  aria-label={gettext("close")}
                >
                  <.icon name="hero-x-mark-solid" class="w-5 h-5" />
                </button>
              </div>
              <div id={"#{@id}-content"}>
                <%= render_slot(@inner_block) %>
              </div>
            </.focus_wrap>
          </div>
        </div>
      </div>
    </div>
    """
  end

  @doc """
  Renders a [Hero Icon](https://heroicons.com).

  Hero icons come in three styles – outline, solid, and mini.
  By default, the outline style is used, but solid an mini may
  be applied by using the `-solid` and `-mini` suffix.

  You can customize the size and colors of the icons by setting
  width, height, and background color classes.

  Icons are extracted from your `assets/vendor/heroicons` directory and bundled
  within your compiled app.css by the plugin in your `assets/tailwind.config.js`.

  ## Examples

      <.icon name="hero-x-mark-solid" />
      <.icon name="hero-arrow-path" class="ml-1 w-3 h-3 animate-spin" />
  """
  attr :name, :string, required: true
  attr :class, :string, default: nil

  @spec icon(map) :: Phoenix.LiveView.Rendered.t()
  def icon(%{name: "hero-" <> _} = assigns) do
    ~H"""
    <span class={[@name, @class]} />
    """
  end

  ## JS Commands

  def show(js \\ %JS{}, selector) do
    JS.show(js,
      to: selector,
      transition:
        {"transition-all transform ease-out duration-300",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95",
         "opacity-100 translate-y-0 sm:scale-100"}
    )
  end

  def hide(js \\ %JS{}, selector) do
    JS.hide(js,
      to: selector,
      time: 200,
      transition:
        {"transition-all transform ease-in duration-200",
         "opacity-100 translate-y-0 sm:scale-100",
         "opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"}
    )
  end

  def show_modal(js \\ %JS{}, id) when is_binary(id) do
    js
    |> JS.show(to: "##{id}")
    |> JS.show(
      to: "##{id}-bg",
      transition: {"transition-all transform ease-out duration-300", "opacity-0", "opacity-100"}
    )
    |> show("##{id}-container")
    |> JS.add_class("overflow-hidden", to: "body")
    |> JS.focus_first(to: "##{id}-content")
  end

  def hide_modal(js \\ %JS{}, id) do
    js
    |> JS.hide(
      to: "##{id}-bg",
      transition: {"transition-all transform ease-in duration-200", "opacity-100", "opacity-0"}
    )
    |> hide("##{id}-container")
    |> JS.hide(to: "##{id}", transition: {"block", "block", "hidden"})
    |> JS.remove_class("overflow-hidden", to: "body")
    |> JS.pop_focus()
  end
end
