defmodule InvestmentTrackerWeb.CSVHTML do
  use InvestmentTrackerWeb, :html

  embed_templates "csv_html/*"

  @doc """
  Renders a csv form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def csv_form(assigns)
end
