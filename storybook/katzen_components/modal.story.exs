defmodule Storybook.Katzen.Components.Modal do
  use PhoenixStorybook.Story, :component
  alias Elixir.Katzen.Components.Modal

  def function, do: &Modal.modal/1

  def imports,
    do: [{Modal, [hide_modal: 1, show_modal: 1]}, {Elixir.Katzen.Components.Button, [button: 1]}]

  def template do
    """
    <.button phx-click={show_modal(":variation_id")} lsb-code-hidden>
      Open modal
    </.button>
    <.lsb-variation/>
    """
  end

  def variations do
    [
      %Variation{
        id: :default,
        slots: ["Modal body"]
      },
      %Variation{
        id: :with_title_and_subtitle,
        slots: [
          "<:title>Title</:title>",
          "<:subtitle>Subtitle</:subtitle>",
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
        ]
      },
      %Variation{
        id: :with_actions,
        attributes: %{
          :on_confirm => {:eval, ~s|hide_modal("modal-single-with-actions")|}
        },
        slots: [
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
          "<:title>Are you sure?</:title>",
          "<:subtitle>Subtitle</:subtitle>",
          "<:confirm>OK</:confirm>",
          "<:cancel>Cancel</:cancel>"
        ]
      }
    ]
  end
end
