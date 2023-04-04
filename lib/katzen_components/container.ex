defmodule Katzen.Components.Container do
  use Phoenix.Component
  import Cvax

  @variants %{
    base: "",
    variants: %{
      variant: %{
        # constrained to breakpoint with padded content
        "one" => "container mx-auto px-4 sm:px-6 lg:px-8",
        # constrained with padded content
        "two" => "mx-auto max-w-7xl px-4 sm:px-6 lg:px-8",
        # full width on mobile constrained to breakpoint with padded content above mobile
        "three" => "container mx-auto sm:px-6 lg:px-8",
        # full width on mobile constrained with padded content above
        "four" => "mx-auto max-w-7xl sm:px-6 lg:px-8",
        # constrained to breakpoint with no padded content after,
        "five" => "p-2 mx-auto lg:max-w-5xl px-2 2xs:px-3 xs:px-4 xl:px-0"
        # TODO: figure out how to add custom break points in twix
        # "six" => "mx-auto base:max-w-base px-2 2xs:px-3 xs:px-4 base:px-0"
      }
    },
    default_variants: %{
      "variant" => "five"
    }
  }

  attr(:variant, :string,
    default: Map.get(@variants.default_variants, "variant"),
    values: Map.keys(@variants.variants.variant),
    doc: "TODO: write doc"
  )

  attr(:class, :string, default: "", doc: "TODO: write doc")
  attr(:rest, :global)
  slot(:inner_block, required: false)

  def container(assigns) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@variants)
      )

    ~H"""
    <div {@rest} class={assigns.variants.(variant: @variant, class: @class) |> Twix.tw()}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
