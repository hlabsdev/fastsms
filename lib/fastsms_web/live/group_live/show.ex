defmodule FastsmsWeb.GroupLive.Show do
  use FastsmsWeb, :live_view

  alias Fastsms.Messaging

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    group = Messaging.get_group!(id)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:group, group)}
  end

  defp page_title(:show), do: "Show Group"
  defp page_title(:edit), do: "Edit Group"
end
