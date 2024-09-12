defmodule FastsmsWeb.SmsLive.Send do
  use FastsmsWeb, :live_view

  alias Fastsms.Messaging
  alias Fastsms.Messaging.SMS

#  @impl true
#  def mount(%{"contact_id" => contact_id}, _session, socket) do
#    contact = Messaging.get_contact!(contact_id)
#    changeset = SMS.changeset(%SMS{}, %{})
#    {:ok, assign(socket, contact: contact, changeset: changeset)}
#  end

  @impl true
  def mount(%{"contact_id" => contact_id}, _session, socket) do
    contact = Messaging.get_contact!(contact_id)
    sms = %SMS{}
#    {:ok, assign(socket, contact: contact, changeset: changeset)}
    {:ok,
      socket
      |> assign(:contact, contact)
      |> assign_new(:form, fn ->
        to_form(Messaging.change_sms(sms))
      end)
    }
  end

  @impl true
  def handle_event("validate", %{"sms" => sms_params}, socket) do
    changeset =
      %SMS{}
      |> SMS.changeset(sms_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  @impl true
  def handle_event("send_sms", %{"sms" => sms_params}, socket) do
    contact = socket.assigns.contact

    # Personnaliser le message avec les variables dynamiques
    message = personalize_message(sms_params["message"], contact)

    case Messaging.send_sms(contact, message) do
#    case Fastsms.Messaging.SMSAPI.send_sms(contact.phone_number, message) do
      :ok ->
        {:noreply,
          socket
          |> put_flash(:info, "SMS envoyé avec succès.")
          |> push_redirect(to: "/contacts")}

      :error ->
        {:noreply, put_flash(socket, :error, "Erreur lors de l'envoi du SMS.")}
    end
  end

  defp personalize_message(message, contact) do
    # Remplacer les variables personnalisées dans le message
    message
    |> String.replace("{{prenom}}", contact.first_name)
    |> String.replace("{{nom}}", contact.last_name)
    |> String.replace("{{email}}", contact.email)
    |> String.replace("{{tel}}", contact.phone_number)
    |> String.replace("{{address}}", contact.address)
  end
end
