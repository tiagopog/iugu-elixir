defmodule Iugu.Invoice do
  @moduledoc """
  Iugu's invoice resource
  """

  @resource "invoices"

  use Iugu.Resource,
    name: @resource,
    actions: [:list, :show, :create],
    fields: [
      :active,
      :bank_slip,
      :commission_cents,
      :commission,
      :credits_based,
      :credits_cycle,
      :credits_min,
      :credits,
      :currency,
      :custom_variables,
      :customer_email,
      :customer_id,
      :customer_name,
      :customer_ref,
      :cycled_at,
      :discount_cents,
      :discount,
      :due_date,
      :email,
      :expires_at,
      :features,
      :financial_return_date,
      :financial_return_dates,
      :in_trial,
      :installments,
      :interest,
      :items_total_cents,
      :items,
      :logs,
      :notification_url,
      :paid_at,
      :plan_identifier,
      :plan_name,
      :plan_ref,
      :price_cents,
      :recent_invoices,
      :refundable,
      :return_url,
      :secure_id,
      :secure_url,
      :status,
      :subitems,
      :suspended,
      :tax_cents,
      :taxes_paid,
      :total_cents,
      :total,
      :user_id,
      :variables
    ]

  @spec capture(String.t()) :: Iugu.Request.post_response()
  @doc """
  Capture invoice - [Iugu Reference](https://dev.iugu.com/v1.0/reference#capturar-fatura)

  ## Parameters

    - id: Iugu invoice ID
  """
  def capture(id) do
    %Iugu.Request{path: "#{@resource}/#{id}/capture"}
    |> Iugu.Request.post(__MODULE__)
  end

  @spec refund(String.t()) :: Iugu.Request.post_response()
  @doc """
  Refund invoice - [Iugu Reference](https://dev.iugu.com/v1.0/reference#reembolsar-fatura)

  ## Parameters

    - id: Iugu invoice ID
  """
  def refund(id) do
    %Iugu.Request{path: "#{@resource}/#{id}/refund"}
    |> Iugu.Request.post(__MODULE__)
  end

  @spec cancel(String.t()) :: Iugu.Request.put_response()
  @doc """
  Cancel a invoice - [Iugu Reference](https://dev.iugu.com/v1.0/reference#cancelar)

  ## Parameters

    - id: Iugu invoice ID
  """
  def cancel(id) do
    %Iugu.Request{path: "#{@resource}/#{id}/cancel"}
    |> Iugu.Request.put(__MODULE__)
  end

  @spec duplicate(map, String.t()) :: Iugu.Request.post_response()
  @doc """
  Duplicate invoice - [Iugu Reference](https://dev.iugu.com/v1.0/reference#gerar-segunda-via)

  ## Parameters

    - data: Map with `:due_date` (required) and another parameters
    - id: Iugu invoice ID
  """
  def duplicate(%{} = data, id) do
    case Poison.encode(data) do
      {:ok, json} ->
        %Iugu.Request{body: json, path: "#{@resource}/#{id}/duplicate"}
        |> Iugu.Request.post(__MODULE__)

      {status, result} ->
        {status, result}
    end
  end

  @spec send_email(String.t()) :: Iugu.Request.post_response()
  @doc """
  Send invoice via email - [Iugu Reference](https://dev.iugu.com/v1.0/reference#enviar-por-email)

  ## Parameters

    - id: Iugu invoice ID
  """
  def send_email(id) do
    %Iugu.Request{path: "#{@resource}/#{id}/send_email"}
    |> Iugu.Request.post(__MODULE__)
  end
end
