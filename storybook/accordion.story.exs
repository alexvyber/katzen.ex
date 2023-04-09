defmodule Storybook.Katzen.Components.Accordion do
  use PhoenixStorybook.Story, :component
  alias Elixir.Katzen.Components.Accordion

  def function, do: &Accordion.accordion/1

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
