defmodule Iugu.Customer do
  @moduledoc """
  Iugu's customer resource
  """

  use Iugu.Resource,
    name: "customers",
    actions: [:list, :show, :create],
    fields: [
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
      :custom_variables
    ]
end
