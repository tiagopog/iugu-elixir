defmodule Iugu.Invoice do
  @moduledoc """
  Iugu's invoice resource
  """

  use Iugu.Resource,
    name: "invoices",
    actions: [:list, :show, :create],
    fields: [
      :active, :credits, :credits_based, :credits_cycle, :credits_min, :currency,
      :customer_email, :customer_id, :customer_name, :customer_ref, :cycled_at,
      :expires_at, :features, :in_trial, :logs, :plan_identifier, :plan_name,
      :plan_ref, :price_cents, :recent_invoices, :subitems, :suspended
    ]
end
