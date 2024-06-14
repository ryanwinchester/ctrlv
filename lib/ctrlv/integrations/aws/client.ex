defmodule Ctrlv.Integrations.AWS.Client do
  @moduledoc """
  AWS Client integration.
  """

  @doc """
  Create a new AWS client.
  """
  def new do
    config = config!()

    AWS.Client.create(
      config.access_key_id,
      config.secret_access_key,
      config.region
    )
    |> AWS.Client.put_http_client({AWS.HTTPClient.Finch, finch_name: Ctrlv.Finch})
  end

  defp config!, do: Application.fetch_env!(:ctrlv, __MODULE__) |> Map.new()
end
