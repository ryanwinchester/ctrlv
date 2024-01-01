defmodule Ctrlv.CodeImage do
  @moduledoc """
  Images from code. These are used for `og:image` tags.
  """

  alias Ctrlv.Integrations.AWS.S3
  alias Ctrlv.Pastes.Paste

  @doc """
  Generate the image from a `Paste` struct.
  """
  @spec from_paste(Paste.t()) :: binary()
  def from_paste(%Paste{content: code, language: language}) do
    generate(code, language)
  end

  @doc """
  Generate the image from code string.
  """
  @spec generate(String.t(), String.t()) :: binary()
  def generate(code, language) do
    Silicon.Native.nif_format(
      code,
      %Silicon.FormatOptions{
        lang: language,
        theme: "TwoDark",
        image_options: %Silicon.ImageOptions{}
      }
    )
  end

  @doc """
  Upload the code image to S3.
  """
  @spec upload(String.t(), binary()) :: {:ok, path :: String.t()} | {:error, term()}
  def upload(filename, image) do
    S3.upload_object(filename, "image/png", image)
  end

  @doc """
  Get the URL for an image by it's path.
  """
  @spec url(String.t()) :: String.t()
  def url(path) do
    S3.get_object_url(path)
  end
end
