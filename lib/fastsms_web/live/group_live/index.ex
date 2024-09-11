defmodule FastsmsWeb.GroupLive.Index do
  use FastsmsWeb, :live_view

  alias Fastsms.Messaging
  alias Fastsms.Messaging.Group

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :groups, Messaging.list_groups())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Group")
    |> assign(:group, Messaging.get_group!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Group")
    |> assign(:group, %Group{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Groups")
    |> assign(:group, nil)
  end

  @impl true
  def handle_info({FastsmsWeb.GroupLive.FormComponent, {:saved, group}}, socket) do
    {:noreply, stream_insert(socket, :groups, group)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    group = Messaging.get_group!(id)
    {:ok, _} = Messaging.delete_group(group)

    {:noreply, stream_delete(socket, :groups, group)}
  end
end
