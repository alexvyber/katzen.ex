defmodule Storybook.Katzen.Components.Textarea do
  use PhoenixStorybook.Story, :component
  alias Elixir.Katzen.Components.Textarea

  def function, do: &Textarea.textarea/1

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
