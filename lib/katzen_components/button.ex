defmodule Katzen.Components.Button do
  use Phoenix.Component
  import Cvax

  @configs %{
    base: [
      "inline-flex items-center justify-center transition duration-200 ease-out gap-2 ",
      # "dark:hover:bg-neutral-800 dark:hover:text-neutral-100",
      # "focus:outline-none focus:ring-2 focus:ring-neutral-400 focus:ring-offset-2",
      # "dark:focus:ring-neutral-400 dark:focus:ring-offset-neutral-900 data-[state=open]:bg-neutral-100 dark:data-[state=open]:bg-neutral-800",
      "disabled:pointer-events-none disabled:opacity-50"
    ],
    variants: %{
      variant: %{
        "simple" => "hover:underline font-semibold text-orange-500",
        "inline" => "hover:underline ",
        "default" => [
          "bg-orange-400 text-white",
          "hover:shadow-lg focus:shadow-lg active:shadow-xl",
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
        "default" => "py-3 px-6",
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
      loading: %{
        true: "cursor-not-allowed pointer-events-none",
        false: nil
      },
      spinner_placement: %{
        "left" => "flex-row",
        "right" => "flex-row-reverse"
      }
    },
    default_variants: %{
      variant: "default",
      padding: "default",
      rounded: "default",
      mode: "light",
      intent: "default",
      disabled: false,
      spinner_placement: "right"
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

  attr(:spinner_placement, :string,
    default: Map.get(@configs.default_variants, :spinner_placement),
    values: Map.keys(@configs.variants[:spinner_placement]),
    doc: "TODO: write doc"
  )

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

  attr(:loading, :boolean, default: false, doc: "loading state")
  attr(:class, :string, default: "", doc: "TODO: write doc")

  def button(%{loading: true} = assigns) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@configs)
      )

    ~H"""
    <button
      class={
        cx(
          @variants.(
            variant: @variant,
            intent: @intent,
            rounded: @rounded,
            padding: @padding,
            class: @class,
            loading: @loading,
            spinner_placement: @spinner_placement
          )
          |> Twix.tw()
        )
      }
      {@rest}
    >
      <Katzen.Components.Loading.spinner />
    </button>
    """
  end

  def button(assigns) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@configs)
      )

    ~H"""
    <button
      class={
        cx(
          @variants.(
            variant: @variant,
            intent: @intent,
            rounded: @rounded,
            padding: @padding,
            class: @class
          )
        )
      }
      {@rest}
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end
end
