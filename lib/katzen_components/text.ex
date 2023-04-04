defmodule Katzen.Components.Typography.Text do
  use Phoenix.Component
  import Cvax

  @moduledoc """
  TODO: write docs
  """

  @variants_config %{
    base: "text-slate-700 dark:text-slate-100",
    variants: %{
      space_between: %{
        true: "[&:not(:first-child)]:mt-4 lg:[&:not(:first-child)]:mt-5"
      }
    },
    default_variants: %{
      "level" => "h2",
      "mode" => "light"
    }
  }

  # @doc """
  # Renders blockquote text

  #   ## Examples

  #     <.subtle>
  #       Lorem Ipsum is simply dummy text of the printing and typesetting industry.
  #       Lorem Ipsum has been the industry's standard dummy text ever since the 1500s...
  #     </.subtle>
  # """

  @doc """
  Renders blockquote text

  ## Default styles:

  ```heex
  <blockquote class={
    cx(["mt-6 border-l-2 border-slate-300 pl-6 italic text-slate-800
        dark:border-slate-600 dark:text-slate-200", @class])}>...</blockquote>
  ```

  Uses [Cvax.cx/1](https://hexdocs.pm/cvax/Cvax.html#cx/1) to generate class string from almost any input

  ## Examples

      <.blockquote>Some Big and Important Header</.blockquote>

  ## Stories

  **[blockquote stories](/#)**
  """
  attr(:class, :string, default: "", doc: "CSS class")
  attr(:rest, :global)
  attr(:content, :string, default: nil, doc: "text content")
  slot(:inner_block, required: false)

  @spec blockquote(map) :: Phoenix.LiveView.Rendered.t()
  def blockquote(assigns) do
    ~H"""
    <blockquote
      class={
        cx([
          "mt-6 border-l-2 border-slate-300 pl-6 italic text-slate-800 dark:border-slate-600 dark:text-slate-200",
          @class
        ])
        |> Twix.tw()
      }
      {@rest}
    >
      <%= render_slot(@inner_block) || @content %>
    </blockquote>
    """
  end

  attr(:space_between, :boolean, default: false)
  attr(:class, :string, default: "", doc: "CSS class")
  attr(:rest, :global)
  attr(:content, :string, default: nil, doc: "text content")
  slot(:inner_block, required: false)

  @doc """
  Renders paragraph

  ## Examples

      <.p>
        Lorem Ipsum is simply dummy text of the printing and typesetting industry.
        Lorem Ipsum has been the industry's standard dummy text ever since the 1500s...
      </.p>
  """

  @spec p(map) :: Phoenix.LiveView.Rendered.t()
  def p(assigns) do
    assigns =
      assign(
        assigns,
        :variants,
        compose_variants(@variants_config)
      )

    ~H"""
    <p
      class={
        @variants.(space_between: @space_between, class: cx(["text-base leading-7", @class]))
        |> Twix.tw()
      }
      {@rest}
    >
      <%= render_slot(@inner_block) || @content %>
    </p>
    """
  end

  # attr(:space_between, :boolean, default: false)
  attr(:class, :string, default: "", doc: "CSS class")
  attr(:rest, :global)
  attr(:content, :string, default: nil, doc: "text content")
  slot(:inner_block, required: false)

  @doc """
  Renders lead paragraph

  ## Examples

      <.lead>
        Lorem Ipsum is simply dummy text of the printing and typesetting industry.
        Lorem Ipsum has been the industry's standard dummy text ever since the 1500s...
      </.lead>
  """
  @spec lead(map) :: Phoenix.LiveView.Rendered.t()
  def lead(assigns) do
    ~H"""
    <p
      class={
        cx(["text-xl text-slate-700 dark:text-slate-200 mb-3", @class])
        |> Twix.tw()
      }
      {@rest}
    >
      <%= render_slot(@inner_block) || @content %>
    </p>
    """
  end

  # attr(:space_between, :boolean, default: false)
  attr(:class, :string, default: "", doc: "CSS class")
  attr(:rest, :global)
  attr(:content, :string, default: nil, doc: "text content")
  slot(:inner_block, required: false)

  @doc """
  Renders large paragraph

  ## Default styles:

  ```heex
  <p class={Cvax.cx(["text-lg font-semibold text-slate-900 dark:text-slate-50", @class])}>...</p>
  ```
  Uses [Cvax.cx/1](https://hexdocs.pm/cvax/Cvax.html#cx/1) to generate class string from almost any input

  ## Examples

      <.large>
        Lorem Ipsum is simply dummy text of the printing and typesetting industry.
        Lorem Ipsum has been the industry's standard dummy text ever since the 1500s...
      </.large>

  ## Stories

  **[large stories](/#)**

  """
  @spec large(map) :: Phoenix.LiveView.Rendered.t()
  def large(assigns) do
    ~H"""
    <p
      class={
        cx(["text-lg font-semibold text-slate-900 dark:text-slate-50", @class])
        |> Twix.tw()
      }
      {@rest}
    >
      <%= render_slot(@inner_block) || @content %>
    </p>
    """
  end

  @doc """
  Renders small text

  uses `small` html tag

  ## Examples

      <.small>
        Lorem Ipsum is simply dummy text of the printing and typesetting industry.
        Lorem Ipsum has been the industry's standard dummy text ever since the 1500s...
      </.small>
  """
  attr(:class, :string, default: "", doc: "CSS class")
  attr(:rest, :global)
  attr(:content, :string, default: nil, doc: "text content")
  slot(:inner_block, required: false)

  @spec small(map) :: Phoenix.LiveView.Rendered.t()
  def small(assigns) do
    ~H"""
    <small
      class={
        cx(["text-sm leading-none text-slate-900 dark:text-slate-50", @class])
        |> Twix.tw()
      }
      {@rest}
    >
      <%= render_slot(@inner_block) || @content %>
    </small>
    """
  end

  @doc """
  Renders subtle text

  uses `p` html tag

  ## Examples

      <.subtle>
        Lorem Ipsum is simply dummy text of the printing and typesetting industry.
        Lorem Ipsum has been the industry's standard dummy text ever since the 1500s...
      </.subtle>
  """
  attr(:class, :string, default: "", doc: "CSS class")
  attr(:rest, :global)
  attr(:content, :string, default: nil, doc: "text content")
  slot(:inner_block, required: false)

  @spec subtle(map) :: Phoenix.LiveView.Rendered.t()
  def subtle(assigns) do
    ~H"""
    <p
      class={
        cx(["text-sm text-slate-500 dark:text-slate-400", @class])
        |> Twix.tw()
      }
      {@rest}
    >
      <%= render_slot(@inner_block) || @content %>
    </p>
    """
  end

  @doc """
  Renders prose

  ## Examples

      <.prose>
        # Heading 1

        some text...
      </.prose>
  """
  attr(:class, :string, default: "", doc: "CSS class")
  attr(:rest, :global)
  attr(:content, :string, default: nil, doc: "text content")
  slot(:inner_block, required: false)

  @spec prose(map) :: Phoenix.LiveView.Rendered.t()
  def prose(assigns) do
    ~H"""
    <div class={Cvax.cx(["prose dark:prose-invert", @class])} {@rest}>
      <%= render_slot(@inner_block) %>
    </div>
    """
  end
end
