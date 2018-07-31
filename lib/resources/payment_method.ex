defmodule Iugu.PaymentMethod do
  @moduledoc """
  Iugu's payment method resource
  """

  defstruct ~w(id description item_type data customer_id errors)a

  @spec list(Iugu.Customer.t()) :: Iugu.Request.get_response()
  @doc """
  List Iugu's Customer Payment Methods

  ## Parameters
    - customer_id: `%Iugu.Customer{}` or a string of Iugu Customer ID
  """
  def list(%Iugu.Customer{id: id}) do
    list(id)
  end

  @spec list(String.t()) :: Iugu.Request.get_response()
  def list(customer_id) do
    %Iugu.Request{path: "customers/#{customer_id}/payment_methods"}
    |> Iugu.Request.get(__MODULE__, :direct_collection)
  end

  @spec create(Iugu.Customer.t(), map) :: Iugu.Request.post_response()
  @doc """
  Creates a Iugu's Payment Method to customer

  ## Parameters
    - customer_id: `%Iugu.Customer{}` or a string of Iugu Customer ID
    - data: map with attributes - [Iugu Reference](https://dev.iugu.com/v1.0/reference#testinput-3)
  """
  def create(%Iugu.Customer{id: id}, %{} = data) do
    create(id, data)
  end

  @spec create(String.t(), map) :: Iugu.Request.post_response()
  def create(customer_id, %{} = data) do
    case Poison.encode(data) do
      {:ok, json} ->
        %Iugu.Request{path: "customers/#{customer_id}/payment_methods", body: json}
        |> Iugu.Request.post(__MODULE__)

      {status, result} ->
        {status, result}
    end
  end

  @spec update(Iugu.Customer.t(), String.t(), map) :: Iugu.Request.put_response()
  @doc """
  Updates a Iugu's Payment Method of a customer

  ## Parameters
    - customer_id: `%Iugu.Customer{}` or a string of Iugu Customer ID
    - id: Iugu Payment Method ID
    - data: map with description attribute - [Iugu Reference](https://dev.iugu.com/v1.0/reference#alterar)
  """
  def update(%Iugu.Customer{id: customer_id}, id, %{} = data) do
    update(customer_id, id, data)
  end

  @spec update(String.t(), String.t(), map) :: Iugu.Request.put_response()
  def update(customer_id, id, %{} = data) do
    case Poison.encode(data) do
      {:ok, json} ->
        %Iugu.Request{body: json, path: "customers/#{customer_id}/payment_methods/#{id}"}
        |> Iugu.Request.put(__MODULE__)

      {status, result} ->
        {status, result}
    end
  end

  @spec show(Iugu.Customer.t(), String.t()) :: Iugu.Request.get_response()
  @doc """
  Returns a Iugu's Payment Method of a customer

  ## Parameters
    - customer_id: `%Iugu.Customer{}` or a string of Iugu Customer ID
    - id: Iugu Payment Method ID - [Iugu Reference](https://dev.iugu.com/v1.0/reference#testinput-4)
  """
  def show(%Iugu.Customer{id: customer_id}, id) do
    show(customer_id, id)
  end

  @spec show(String.t(), String.t()) :: Iugu.Request.get_response()
  def show(customer_id, id) do
    %Iugu.Request{path: "customers/#{customer_id}/payment_methods/#{id}"}
    |> Iugu.Request.get(__MODULE__, :single)
  end

  @spec delete(Iugu.Customer.t(), String.t()) :: Iugu.Request.delete_response()
  @doc """
  Delete a Iugu's Payment Method of a customer

  ## Parameters
    - customer_id: `%Iugu.Customer{}` or a string of Iugu Customer ID
    - id: Iugu Payment Method ID - [Iugu Reference](https://dev.iugu.com/v1.0/reference#remover-2)
  """
  def delete(%Iugu.Customer{id: customer_id}, id) do
    delete(customer_id, id)
  end

  @spec delete(String.t(), String.t()) :: Iugu.Request.delete_response()
  def delete(customer_id, id) do
    %Iugu.Request{path: "customers/#{customer_id}/payment_methods/#{id}"}
    |> Iugu.Request.delete(__MODULE__)
  end
end
