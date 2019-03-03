defmodule Iugu.Chargeback do
  @moduledoc """
  Iugu's chargeback resource
  """

  @resource "chargebacks"

  use Iugu.Resource,
    name: @resource,
    actions: [:list, :show],
    fields: [:invoice_id, :status, :expires_at]

  @spec accept(String.t()) :: Iugu.Request.put_response()
  @doc """
  Accept a chargeback - [Iugu Reference](https://dev.iugu.com/v1.0/reference#acatar)

  ## Parameters

    - id: Iugu chargeback ID
  """
  def accept(id) do
    %Iugu.Request{path: "#{@resource}/#{id}/accept"}
    |> Iugu.Request.put(__MODULE__)
  end

  @spec contest(String.t()) :: Iugu.Request.put_response()
  @doc """
  Contest a chargeback - [Iugu Reference](https://dev.iugu.com/v1.0/reference#contest)

  ## Parameters

    - id: Iugu chargeback ID
  """
  def contest(id) do
    %Iugu.Request{path: "#{@resource}/#{id}/contest"}
    |> Iugu.Request.put(__MODULE__)
  end
end
