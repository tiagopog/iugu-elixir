defmodule Iugu.Subscription do
  @moduledoc """
  Iugu's subscription resource
  """

  @resource "subscriptions"

  use Iugu.Resource,
    name: @resource,
    actions: [:list, :show, :create, :update, :delete],
    fields: [
      :bank_slip,
      :commission,
      :commission_cents,
      :currency,
      :custom_variables,
      :customer_id,
      :discount,
      :discount_cents,
      :due_date,
      :email,
      :financial_return_date,
      :financial_return_dates,
      :installments,
      :interest,
      :items,
      :items_total_cents,
      :logs,
      :notification_url,
      :paid_at,
      :refundable,
      :return_url,
      :secure_id,
      :secure_url,
      :status,
      :tax_cents,
      :taxes_paid,
      :total,
      :total_cents,
      :user_id,
      :variables,
      :plan_identifier
    ]

  @spec activate(String.t()) :: Iugu.Request.post_response()
  @doc """
  Activate a Subscription - [Iugu Reference](https://dev.iugu.com/v1.0/reference#ativar)

  ## Parameters

    - id: Iugu subscription ID
  """
  def activate(id) do
    %Iugu.Request{path: "#{@resource}/#{id}/activate"}
    |> Iugu.Request.post(__MODULE__)
  end

  @spec suspend(String.t()) :: Iugu.Request.post_response()
  @doc """
  Suspend a Subscription - [Iugu Reference](https://dev.iugu.com/v1.0/reference#suspender)

  ## Parameters

    - id: Iugu subscription ID
  """
  def suspend(id) do
    %Iugu.Request{path: "#{@resource}/#{id}/suspend"}
    |> Iugu.Request.post(__MODULE__)
  end

  @spec update_plan(String.t(), String.t()) :: Iugu.Request.post_response()
  @doc """
  Changes the plan for a Subscription - [Iugu Reference](https://dev.iugu.com/v1.0/reference#alterar-o-plano)

  ## Parameters

    - id: Iugu subscription ID
    - new_plan_identifier: Iugu plan identifier
  """
  def update_plan(id, new_plan_identifier) do
    %Iugu.Request{path: "#{@resource}/#{id}/change_plan/#{new_plan_identifier}"}
    |> Iugu.Request.post(__MODULE__)
  end

  @spec update_plan_simulation(String.t(), String.t()) :: Iugu.Request.put_response()
  @doc """
  Simulates a plan change of a subscription - [Iugu Reference](https://dev.iugu.com/v1.0/reference#simular-alteração-de-plano)

  ## Parameters

    - data: Map with quantity `%{quantity: integer}`
    - id: Iugu subscription ID
  """
  def update_plan_simulation(id, new_plan_identifier) do
    %Iugu.Request{path: "#{@resource}/#{id}/change_plan_simulation/#{new_plan_identifier}"}
    |> Iugu.Request.put(__MODULE__)
  end

  @spec add_credits(map, String.t()) :: Iugu.Request.put_response()
  @doc """
  Add credits to a subscription - [Iugu Reference](https://dev.iugu.com/v1.0/reference#adicionar-créditos)

  ## Parameters

    - data: Map with quantity `%{quantity: integer}`
    - id: Iugu subscription ID
  """
  def add_credits(%{} = data, id) do
    case Poison.encode(data) do
      {:ok, json} ->
        %Iugu.Request{body: json, path: "#{@resource}/#{id}/add_credits"}
        |> Iugu.Request.put(__MODULE__)

      {status, result} ->
        {status, result}
    end
  end
end
