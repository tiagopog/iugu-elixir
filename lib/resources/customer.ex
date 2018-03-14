defmodule Iugu.Customer do
  @moduledoc """
  Iugu Customer resource
  """

  use Iugu.Resource
  alias Iugu.Request

  @resource "customers"

  defstruct [
    :id,
    :email,
    :name,
    :notes,
    :city,
    :cpf_cnpj,
    :cc_emails,
    :zip_code,
    :number,
    :complement,
    :default_payment_method_id,
    :proxy_payments_from_customer_id,
    :state,
    :district,
    :street,
    :custom_variables,
    :created_at,
    :updated_at
  ]

  def list(%Request{} = request) do
    Iugu.get(request, @resource, __MODULE__)
  end
end
