defmodule KatzenWeb.Live.Index do
  use KatzenWeb, :live_view

  alias Katzen.Catalog
  alias Katzen.Catalog.Product

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       modal: false
     )}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    case socket.assigns.live_action do
      :index ->
        {:noreply, assign(socket, modal: false)}

      :modal ->
        {:noreply, assign(socket, modal: %{size: params["size"] || "3xl"})}
    end
  end
end
