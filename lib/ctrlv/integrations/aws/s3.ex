defmodule Ctrlv.Integrations.AWS.S3 do
  @moduledoc """
  AWS S3 API integrations.
  """

  alias Ctrlv.Integrations.AWS.Client

  require Logger

  def upload(filename, content_type, content) do
    client = Client.new()
    bucket = config!(:bucket)
    filename = Path.join("ctrlv-images", filename)

    body = %{
      "Body" => content,
      "ContentMD5" => :crypto.hash(:md5, content) |> Base.encode64(),
      "ContentType" => content_type
    }

    case AWS.S3.put_object(client, bucket, filename, body, _options = []) do
      {:ok, _result, _resp} ->
        {:ok, filename}

      {:error, {:unexpected_response, resp}} ->
        Logger.error("Bad upload: #{inspect(resp)}")
        {:error, resp}

      {:error, reason} ->
        Logger.error("Error uploading: #{inspect(reason)}")
        {:error, reason}
    end
  end

  defp config!(key) do
    Application.fetch_env!(:ctrlv, __MODULE__) |> Keyword.fetch!(key)
  end
end
