defmodule Fastsms.Messaging.SMSAPI do
  @wassa_key "OVW2qZYivGzZUH3Hh7JDaK0jaoFC6lPc"
  @wassa_url "http://www.wassasms.com/wassasms/api/web/v3/sends"
  @sender "GABIN"

  def send_sms(contact_number, message_text) do
    # Créer les paramètres pour la requête
    params = %{
      "access-token" => @wassa_key,
      "sender" => @sender,
      "receiver" => contact_number,
      "text" => message_text
    }

    # Encoder les paramètres en URL
    encoded_params = URI.encode_query(params)

    # Envoyer la requête GET à l'API Wassa
    case HTTPoison.get("#{@wassa_url}?#{encoded_params}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts("Réponse ==> #{inspect(body)}")
        # Si le statut est 200, on peut loguer ou faire un traitement du succès
        {:ok, body}

      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        IO.puts("Erreur : Statut ==> #{status_code}, Réponse ==> #{inspect(body)}")
        {:error, body}

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.puts("Erreur lors de l'envoi du SMS ==> #{inspect(reason)}")
        {:error, reason}
    end
  end
end
