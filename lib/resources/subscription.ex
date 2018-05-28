defmodule Iugu.Subscription do
  @moduledoc """
  Iugu's subscription resource
  """

  use Iugu.Resource,
    name: "subscriptions",
    actions: [:list, :show, :create],
    fields: [
      :bank_slip, :commission, :commission_cents, :currency, :custom_variables,
      :customer_id, :discount, :discount_cents, :due_date, :email,
      :financial_return_date, :financial_return_dates, :installments, :interest,
      :items, :items_total_cents, :logs, :notification_url, :paid_at, :refundable,
      :return_url, :secure_id, :secure_url, :status, :tax_cents, :taxes_paid,
      :total, :total_cents, :user_id, :variables, :plan_identifier
    ]
end
