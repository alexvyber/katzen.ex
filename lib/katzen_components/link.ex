defmodule Katzen.Components.Link do
  use Phoenix.Component
  import Cvax

  @configs %{
    base: [
      "inline-flex items-center justify-center  transition duration-200 ease-out"
      # "dark:hover:bg-neutral-800 dark:hover:text-neutral-100",
      # "focus:outline-none focus:ring-2 focus:ring-neutral-400 focus:ring-offset-2",
      # "dark:focus:ring-neutral-400 dark:focus:ring-offset-neutral-900 data-[state=open]:bg-neutral-100 dark:data-[state=open]:bg-neutral-800",

      # "active:scale-95",
    ],
    variants: %{
      variant: %{
        "simple" => "hover:underline font-semibold text-orange-500",
        "inline" => "hover:underline ",
        "default" => [
          "bg-orange-400 text-white",
          "hover:shadow-lg focus:shadow-lg active:shadow-xl hover:translate-y-px",
          "dark:bg-orange-400 dark:text-black"
        ],
        "outline" => [
          "bg-transparent ring-1 ring-orange-400 hover:ring-orange-500 hover:ring-2",
          "dark:ring-orange-400 dark:text-white"
        ],
        "subtle" => [
          "bg-orange-100 text-neutral-900 hover:bg-orange-200",
          "dark:bg-slate-700  dark:hover:bg-slate-600 dark:text-neutral-100"
        ],
        "ghost" => [
          [
            "bg-transparent hover:bg-neutral-100 ",
            "dark:text-white dark:hover:bg-slate-800"
          ]
        ]
      },
      intent: %{
        "default" => nil,
        "success" => nil,
        "info" => nil,
        "danger" => "font-bold ",
        "warning" => nil
      },
      padding: %{
        "default" => "py-3 px-4",
        "none" => "p-0",
        "lg" => "py-2.5 px-8 rounded-md"
      },
      rounded: %{
        "default" => "rounded-lg",
        "none" => "rounded-none",
        "sm" => "rounded-sm",
        "lg" => "rounded-lg",
        "xl" => "rounded-xl",
        "2xl" => "rounded-xl md:rounded-2xl"
      },
      disabled: %{
        true: "pointer-events-none opacity-50",
        false: nil
      }
    },
    default_variants: %{
      variant: "default",
      padding: "default",
      rounded: "default",
      mode: "light",
      intent: "default",
      disabled: false
    },
    compound_variants: [
      %{
        "variant" => "outline",
        "mode" => "dark",
        "className" => ["ring-white text-white"]
      },
      %{
        "variant" => "outline",
        "mode" => "light",
        "className" => ["ring-dark text-dark"]
      }
    ]
  }

  # attr(:href, :string,
  #   default: nil,
  #   doc: "TODO: write doc"
  # )

  attr(:variant, :string,
    default: Map.get(@configs.default_variants, :variant),
    values: Map.keys(@configs.variants[:variant]),
    doc: "TODO: write doc"
  )

  attr(:intent, :string,
    default: Map.get(@configs.default_variants, :intent),
    values: Map.keys(@configs.variants[:intent]),
    doc: "TODO: write doc"
  )

  attr(:padding, :string,
    default: Map.get(@configs.default_variants, :padding),
    values: Map.keys(@configs.variants[:padding]),
    doc: "TODO: write doc"
  )

  attr(:rounded, :string,
    default: Map.get(@configs.default_variants, :rounded),
    values: Map.keys(@configs.variants[:rounded]),
    doc: "TODO: write doc"
  )

  # attr(:loading, :boolean, default: false, doc: "loading state")
  attr(:disabled, :boolean, default: false, doc: "disabled state")

  attr(:navigate, :string,
    doc: """
    Navigates from a LiveView to a new LiveView.
    The browser page is kept, but a new LiveView process is mounted and its content on the page
    is reloaded. It is only possible to navigate between LiveViews declared under the same router
    `Phoenix.LiveView.Router.live_session/3`. Otherwise, a full browser redirect is used.
    """
  )

  attr(:patch, :string,
    doc: """
    Patches the current LiveView.
    The `handle_params` callback of the current LiveView will be invoked and the minimum content
    will be sent over the wire, as any other LiveView diff.
    """
  )

  attr(:href, :any,
    doc: """
    Uses traditional browser navigation to the new location.
    This means the whole page is reloaded on the browser.
    """
  )

  attr(:replace, :boolean,
    default: false,
    doc: """
    When using `:patch` or `:navigate`,
    should the browser's history be replaced with `pushState`?
    """
  )

  attr(:method, :string,
    default: "get",
    doc: """
    The HTTP method to use with the link. This is intended for usage outside of LiveView
    and therefore only works with the `href={...}` attribute. It has no effect on `patch`
    and `navigate` instructions.
    In case the method is not `get`, the link is generated inside the form which sets the proper
    information. In order to submit the form, JavaScript must be enabled in the browser.
    """
  )

  attr(:csrf_token, :any,
    default: true,
    doc: """
    A boolean or custom token to use for links with an HTTP method other than `get`.
    """
  )

  attr(:rest, :global,
    include: ~w(download hreflang referrerpolicy rel target type),
    doc: """
    Additional HTML attributes added to the `a` tag.
    """
  )

  slot(:inner_block,
    required: true,
    doc: """
    The content rendered inside of the `a` tag.
    """
  )

  attr(:class, :string, default: "", doc: "TODO: write doc")

  @spec a(map) :: Phoenix.LiveView.Rendered.t()
  def a(%{navigate: to} = assigns) when is_binary(to) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@configs)
      )

    ~H"""
    <.link
      navigate={@navigate}
      class={
        cx(
          @variants.(
            variant: @variant,
            intent: @intent,
            rounded: @rounded,
            padding: @padding,
            disabled: @disabled,
            class: @class
          )
        )
        |> Twix.tw()
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  def a(%{patch: to} = assigns) when is_binary(to) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@configs)
      )

    ~H"""
    <.link
      patch={@patch}
      class={
        cx(
          @variants.(
            variant: @variant,
            intent: @intent,
            rounded: @rounded,
            padding: @padding,
            disabled: @disabled,
            class: @class
          )
        )
        |> Twix.tw()
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  def a(%{href: href} = assigns) when href != "#" and not is_nil(href) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@configs)
      )

    ~H"""
    <.link
      href={@href}
      class={
        cx(
          @variants.(
            variant: @variant,
            intent: @intent,
            rounded: @rounded,
            padding: @padding,
            disabled: @disabled,
            class: @class
          )
        )
        |> Twix.tw()
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </.link>
    """
  end

  def a(assigns) do
    ~H"""
    <.link href="#" {@rest}><%= render_slot(@inner_block) %></.link>
    """
  end
end
