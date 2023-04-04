defmodule Storybook.Katzen.Components.Headers do
  use PhoenixStorybook.Story, :component
  alias Elixir.Katzen.Components.Typography.Headers

  def function, do: &Headers.h2/1

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
