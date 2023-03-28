defmodule InvestmentTrackerWeb.InvestmentHTML do
  use InvestmentTrackerWeb, :html

  embed_templates "investment_html/*"

  @doc """
  Renders a investment form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def investment_form(assigns)
end
