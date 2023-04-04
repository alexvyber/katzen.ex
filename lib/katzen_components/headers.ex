defmodule Katzen.Components.Typography.Headers do
  use Phoenix.Component
  import Cvax

  @moduledoc """
  Headers
  """

  # <.h1>Header 1</.h1>
  # <.h1 content="Header 1" />
  # <.h1 content="Header 1" class="mb-10" color_class="text-blue-500" />

  @variants_config %{
    base: "text-slate-900 dark:text-slate-50",
    variants: %{
      level: %{
        "pageTitle" => "text-4xl 2xs:text-5xl xs:text-6xl sm:text-7xl md:text-8xl lg:text-9xl",
        "h1" => "scroll-m-20 text-4xl font-extrabold tracking-tight lg:text-5xl",
        "h2" => "scroll-m-20 text-3xl font-bold tracking-tight lg:text-4xl ",
        "h3" => "scroll-m-20 text-2xl font-semibold tracking-tight lg:text-3xl ",
        "h4" => "scroll-m-20 text-xl font-semibold tracking-tight lg:text-2xl",
        "h5" => "text-lg  font-semibold ",
        "h6" => "text-lg font-semibold "
      },
      mode: %{
        "light" => "text-black",
        "dark" => "text-white"
      },
      offset: %{
        "top" => "mt-6",
        "bottom" => "mb-3",
        "both" => "mt-6 mb-3",
        "none" => nil
      }
    },
    default_variants: %{
      "level" => "h2",
      "mode" => "light",
      "offset" => "none"
    }
  }

  attr(:level, :string,
    default: "h1",
    values: Map.keys(@variants_config.variants.level),
    doc: "TODO: write doc"
  )

  attr(:offset, :string,
    default: Map.get(@variants_config.default_variants, "offset"),
    values: Map.keys(@variants_config.variants.offset),
    doc: "TODO: write doc"
  )

  attr(:as, :string,
    default: "h1",
    values: ["h1", "h2", "h3", "h4", "h5", "h6"],
    doc: "TODO: write docs"
  )

  attr(:content, :string, default: nil, doc: "text content")
  attr(:class, :string, default: "", doc: "CSS class")
  slot(:inner_block, required: false)
  attr(:rest, :global)

  @doc """
  Renders h1 heading

  ## Default styles:

  ```heex
  <h1 class={Cvax.cx(["text-slate-900 dark:text-slate-50 scroll-m-20 text-4xl
          font-extrabold tracking-tight lg:text-5xl text-black", @class])}>...</h1>
  ```
  Uses [Cvax.cx/1](https://hexdocs.pm/cvax/Cvax.html#cx/1) to generate class string from almost any input

  ## Examples

    <.h1>Some Big and Important Header</.h1>

  ## Stories

  **[h1 stories](/#)**

  """
  @spec h1(map) :: Phoenix.LiveView.Rendered.t()
  def h1(assigns) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@variants_config)
      )

    ~H"""
    <%= Phoenix.HTML.Tag.content_tag(
      @as,
      render_slot(@inner_block) || @content,
      Map.to_list(
        Map.put(@rest, :class, @variants.(level: @level, offset: @offset, class: @class) |> Twix.tw())
      )
    ) %>
    """
  end

  attr(:level, :string,
    default: "h2",
    values: Map.keys(@variants_config.variants.level),
    doc: "TODO: write doc"
  )

  attr(:offset, :string,
    default: Map.get(@variants_config.default_variants, "offset"),
    values: Map.keys(@variants_config.variants.offset),
    doc: "TODO: write doc"
  )

  attr(:class, :string, default: "", doc: "CSS class")
  attr(:content, :string, default: nil, doc: "text content")
  attr(:rest, :global)

  attr(:as, :string, default: "h2", values: ["h1", "h2", "h3", "h4", "h5", "h6"], doc: "CSS class")

  slot(:inner_block, required: false)

  def h2(assigns) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@variants_config)
      )

    ~H"""
    <%= Phoenix.HTML.Tag.content_tag(
      @as,
      render_slot(@inner_block) || @content,
      Map.to_list(
        Map.put(@rest, :class, @variants.(level: @level, offset: @offset, class: @class) |> Twix.tw())
      )
    ) %>
    """
  end

  attr(:level, :string,
    default: "h3",
    values: Map.keys(@variants_config.variants.level),
    doc: "TODO: write doc"
  )

  attr(:offset, :string,
    default: Map.get(@variants_config.default_variants, "offset"),
    values: Map.keys(@variants_config.variants.offset),
    doc: "TODO: write doc"
  )

  attr(:class, :string, default: "", doc: "CSS class")
  attr(:content, :string, default: nil, doc: "text content")
  attr(:rest, :global)

  attr(:as, :string, default: "h3", values: ["h1", "h2", "h3", "h4", "h5", "h6"], doc: "CSS class")

  slot(:inner_block, required: false)

  def h3(assigns) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@variants_config)
      )

    ~H"""
    <%= Phoenix.HTML.Tag.content_tag(
      @as,
      render_slot(@inner_block) || @content,
      Map.to_list(
        Map.put(@rest, :class, @variants.(level: @level, offset: @offset, class: @class) |> Twix.tw())
      )
    ) %>
    """
  end

  attr(:level, :string,
    default: "h4",
    values: Map.keys(@variants_config.variants.level),
    doc: "TODO: write doc"
  )

  attr(:offset, :string,
    default: Map.get(@variants_config.default_variants, "offset"),
    values: Map.keys(@variants_config.variants.offset),
    doc: "TODO: write doc"
  )

  attr(:class, :string, default: "", doc: "CSS class")
  attr(:content, :string, default: nil, doc: "text content")
  attr(:rest, :global)

  attr(:as, :string, default: "h4", values: ["h1", "h2", "h3", "h4", "h5", "h6"], doc: "CSS class")

  slot(:inner_block, required: false)

  def h4(assigns) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@variants_config)
      )

    ~H"""
    <%= Phoenix.HTML.Tag.content_tag(
      @as,
      render_slot(@inner_block) || @content,
      Map.to_list(
        Map.put(@rest, :class, @variants.(level: @level, offset: @offset, class: @class) |> Twix.tw())
      )
    ) %>
    """
  end

  attr(:level, :string,
    default: "h5",
    values: Map.keys(@variants_config.variants.level),
    doc: "TODO: write doc"
  )

  attr(:offset, :string,
    default: Map.get(@variants_config.default_variants, "offset"),
    values: Map.keys(@variants_config.variants.offset),
    doc: "TODO: write doc"
  )

  attr(:class, :string, default: "", doc: "CSS class")
  attr(:content, :string, default: nil, doc: "text content")
  attr(:rest, :global)

  attr(:as, :string, default: "h5", values: ["h1", "h2", "h3", "h4", "h5", "h6"], doc: "CSS class")

  slot(:inner_block, required: false)

  def h5(assigns) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@variants_config)
      )

    ~H"""
    <%= Phoenix.HTML.Tag.content_tag(
      @as,
      render_slot(@inner_block) || @content,
      Map.to_list(
        Map.put(@rest, :class, @variants.(level: @level, offset: @offset, class: @class) |> Twix.tw())
      )
    ) %>
    """
  end

  attr(:level, :string,
    default: "h6",
    values: Map.keys(@variants_config.variants.level),
    doc: "TODO: write doc"
  )

  attr(:offset, :string,
    default: Map.get(@variants_config.default_variants, "offset"),
    values: Map.keys(@variants_config.variants.offset),
    doc: "TODO: write doc"
  )

  attr(:class, :string, default: "", doc: "CSS class")
  attr(:content, :string, default: nil, doc: "text content")
  attr(:rest, :global)

  attr(:as, :string, default: "h6", values: ["h1", "h2", "h3", "h4", "h5", "h6"], doc: "CSS class")

  slot(:inner_block, required: false)

  def h6(assigns) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@variants_config)
      )

    ~H"""
    <%= Phoenix.HTML.Tag.content_tag(
      @as,
      render_slot(@inner_block) || @content,
      Map.to_list(
        Map.put(@rest, :class, @variants.(level: @level, offset: @offset, class: @class) |> Twix.tw())
      )
    ) %>
    """
  end
end
