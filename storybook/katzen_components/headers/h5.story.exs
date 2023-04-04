defmodule Storybook.Katzen.Components.Headers do
  use PhoenixStorybook.Story, :component
  alias Elixir.Katzen.Components.Typography.Headers

  def function, do: &Headers.h5/1

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
