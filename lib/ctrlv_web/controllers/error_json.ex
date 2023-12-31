defmodule CtrlvWeb.ErrorJSON do
  @moduledoc false

  def render("422.json", %{changeset: changeset}) do
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)}
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  defp translate_error({msg, opts}) do
    IO.inspect(msg, label: "message")
    IO.inspect(opts, label: "opts")
    # set by Ecto and indicates we should also apply plural rules.
    if count = opts[:count] do
      Gettext.dngettext(CtrlvWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(CtrlvWeb.Gettext, "errors", msg, opts)
    end
  end
end
