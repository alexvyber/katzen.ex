defmodule Katzen.Components.Separator do
  use Phoenix.Component

  attr(:orientation, :string,
    default: "horizontal",
    values: ["vertical", "horizontal"],
    doc: "TODO: write doc"
  )

  attr(:class, :string, default: "", doc: "TODO: write doc")
  attr(:rest, :global)

  @spec separator(map) :: Phoenix.LiveView.Rendered.t()
  def separator(assigns) do
    ~H"""
    <div
      {@rest}
      class={
        Cvax.cx([
          "bg-slate-200 dark:bg-slate-700",
          if(@orientation == "horizontal", do: "h-[1px] w-full", else: "h-full w-[1px]"),
          @class
        ])
        |> Twix.tw()
      }
    />
    """
  end
end
