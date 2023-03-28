defmodule InvestmentTrackerWeb.OperationHTML do
  use InvestmentTrackerWeb, :html

  embed_templates "operation_html/*"

  @doc """
  Renders a operation form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def operation_form(assigns)
end
