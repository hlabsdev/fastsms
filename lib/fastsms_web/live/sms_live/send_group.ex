defmodule FastsmsWeb.SmsLive.SendGroup do
  use FastsmsWeb, :live_view

  alias Fastsms.Repo
  alias Fastsms.Messaging
  alias Fastsms.Messaging.SMS

  @impl true
  def mount(%{"group_id" => group_id}, _session, socket) do
    group = Messaging.get_group!(group_id) |> Repo.preload(:contacts)
#    changeset = SMS.changeset(%SMS{}, %{})
#    {:ok, assign(socket, group: group, contacts: group.contacts, changeset: changeset)}
    sms = %SMS{}
    #    {:ok, assign(socket, contact: contact, changeset: changeset)}
    {:ok,
      socket
      |> assign(:group, group)
      |> assign(:contacts, group.contacts)
      |> assign_new(:form, fn ->
        to_form(Messaging.change_sms(sms))
      end)
    }
  end

  @impl true
  def handle_event("send_sms_group", %{"sms" => sms_params}, socket) do
    contacts = socket.assigns.contacts
    message = sms_params["message"]

    # Envoyer un SMS à chaque contact du groupe avec personnalisation
    Enum.each(contacts, fn contact ->
      personalized_message = personalize_message(message, contact)
      Messaging.send_sms(contact, personalized_message)
    end)

    {:noreply,
      socket
      |> put_flash(:info, "SMS envoyés au groupe avec succès.")
      |> push_redirect(to: "/groups")}
  end

  defp personalize_message(message, contact) do
    message
    |> String.replace("{{prenom}}", contact.first_name)
    |> String.replace("{{nom}}", contact.last_name)
    |> String.replace("{{email}}", contact.email)
    |> String.replace("{{tel}}", contact.phone_number)
    |> String.replace("{{address}}", contact.address)
  end
end
