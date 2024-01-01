defmodule Ctrlv.CodeImage do
  @moduledoc """
  Generate an image from the code.
  """

  alias Ctrlv.Integrations.AWS.S3
  alias Ctrlv.Pastes.Paste

  @doc """
  Generate the image.
  """
  def from_paste(%Paste{content: code, language: lang}) do
    Silicon.Native.nif_format(
      code,
      %Silicon.FormatOptions{
        lang: lang,
        theme: "Dracula",
        image_options: %Silicon.ImageOptions{}
      }
    )
  end

  def upload(filename, image) do
    S3.upload(filename, "image/png", image)
  end
end
