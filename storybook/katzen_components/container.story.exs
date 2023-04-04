defmodule Storybook.Katzen.Components.Container do
  use PhoenixStorybook.Story, :component
  alias Elixir.Katzen.Components.Container

  def function, do: &Container.container/1

  def variations do
    [
      %Variation{
        id: :default,
        slots: [
          "Hello World"
        ]
      }
    ]
  end
end
