defmodule FastsmsWeb.GroupLive.FormComponent do
  use FastsmsWeb, :live_component

  alias Fastsms.Messaging

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage group records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="group-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <!-- Section for contact search and selection -->
        <div class="contact-selection">
          <h3>Select contacts to add to the group:</h3>
          <!-- Search input for filtering contacts -->
          <.input
            type="text"
            name="search"
            id="search"
            value=""
            placeholder="Rechercher un contact"
            phx-keyup="filter_contacts"
            phx-debounce="5000"
          />
          <%!-- <input type="text" placeholder="Rechercher un contact" phx-keyup="filter_contacts" phx-debounce="300"> --%>
          <!-- List of filtered contacts with checkboxes -->
          <%!-- <.input
            field={@form[:contact_ids]}
            type="select"
            selected={contact_in_group(@group.contacts, @id)}
            multiple={true}
            options={list_contacts()}
            label="Contacts"
          /> --%>
          <ul>
            <%= for contact <- @filtered_contacts do %>
              <li>
                <label>
                  <%!-- <input type="checkbox" name="group[contact_ids][]" value={contact.id} <%= if contact_in_group(@group.contacts, contact.id), do: "checked" %> /> --%>
                  <input type="checkbox" name="group[contact_ids][]" value={contact.id} checked={contact_in_group?(@group.contacts, contact.id)} />
                  <%!--<input type="checkbox" name="group[contact_ids][]" value={contact.id} checked={@group.contacts |> Enum.member?(contact.id)} />--%>
                  <%= "#{contact.first_name} #{contact.last_name} - #{contact.phone_number}" %>
                </label>
              </li>
            <% end %>
          </ul>
        </div>

        <:actions>
          <.button phx-disable-with="Saving...">Save Group</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{group: group} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Messaging.change_group(group))
     end)
     |> assign(:filtered_contacts, list_contacts())
    }
  end

  @impl true
  def handle_event("validate", %{"group" => group_params}, socket) do
    changeset = Messaging.change_group(socket.assigns.group, group_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"group" => group_params}, socket) do
    save_group(socket, socket.assigns.action, group_params)
  end

  @impl true
  def handle_event("filter_contacts", %{"value" => search_term}, socket) do
    filtered_contacts = list_contacts(search_term)
    {:noreply, assign(socket, :filtered_contacts, filtered_contacts)}
  end

  defp list_contacts(search_term \\ "") do
    Messaging.list_contacts()
    |> Enum.filter(fn contact ->
      String.contains?(contact.first_name, search_term) or
        String.contains?(contact.last_name, search_term) or
        String.contains?(contact.phone_nmber, search_term)
    end)
  end

  defp save_group(socket, :edit, group_params) do
    contact_ids = Map.get(group_params, "contact_ids", [])

    case Messaging.update_group_with_contact(socket.assigns.group.id, contact_ids) do
      {:ok, group} ->
        notify_parent({:saved, group})

        {:noreply,
         socket
         |> put_flash(:info, "Group updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_group(socket, :new, group_params) do
    contact_ids = Map.get(group_params, "contact_ids", [])

    case Messaging.create_group_with_contacts(group_params, contact_ids) do
      {:ok, group} ->
        notify_parent({:saved, group})

        {:noreply,
         socket
         |> put_flash(:info, "Groupe créé avec succès")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

  defp contact_in_group?(group_contacts, contact_id) do
       Enum.any?(group_contacts, fn gc -> gc.id == contact_id end)
  end
end
