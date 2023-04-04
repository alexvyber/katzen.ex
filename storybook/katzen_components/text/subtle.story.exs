defmodule Storybook.Katzen.Components.Headers do
  use PhoenixStorybook.Story, :component
  alias Elixir.Katzen.Components.Typography.Text

  def function, do: &Text.subtle/1

  def variations do
    [
      %Variation{
        id: :default,
        slots: [
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s..."
        ]
      },
      %Variation{
        id: :other,
        slots: [
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s..."
        ]
      }
    ]
  end
end
