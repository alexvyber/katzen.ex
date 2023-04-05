defmodule Katzen.Components.Textarea do
  use Phoenix.Component
  # TODO: finish component

  @doc """
  Renders textarea

  ## Default styles:

  ```heex
  <textarea
      class={
        Cvax.cx([
          "flex h-20 w-full rounded-md border border-slate-300 bg-transparent py-2 px-3 text-sm placeholder:text-slate-400",
          "focus:outline-none focus:ring-2 focus:ring-slate-400 focus:ring-offset-2",
          "disabled:cursor-not-allowed disabled:opacity-50",
          "dark:border-slate-700 dark:text-slate-50 dark:focus:ring-slate-400 dark:focus:ring-offset-slate-900",
          @class
        ])
      }
      {@rest}
    />
  ```
  Uses [Cvax.cx/1](https://hexdocs.pm/cvax/Cvax.html#cx/1) to generate class string from almost any input

  ## Examples

    <.textarea>...</.textarea>

  ## Stories

  **[textarea stories](/#)**
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

  @spec textarea(map) :: Phoenix.LiveView.Rendered.t()
  def textarea(assigns) do
    ~H"""
    <textarea
      class={
        Cvax.cx([
          "flex min-h-20 w-full rounded-md border border-slate-300 bg-transparent py-1 px-2 text-sm placeholder:text-slate-400",
          "focus:outline-none focus:ring-1 focus:ring-slate-400 focus:ring-offset-2",
          "disabled:cursor-not-allowed disabled:opacity-50",
          "dark:border-slate-700 dark:text-slate-50 dark:focus:ring-slate-400 dark:focus:ring-offset-slate-900",
          @class
        ])
      }
      {@rest}
    />
    """
  end
end
