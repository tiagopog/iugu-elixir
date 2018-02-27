defmodule Iugu.CustomerApi do
  @moduledoc """
  Iugu Customer API module
  """

  alias Iugu.{Client,CommonApi,Customer}

  @schema Customer
  @resource "customers"

  def list(%Client{} = client) do
    CommonApi.get!(%Client{client| resource: @resource}, @schema)
    # {:ok, [%Iugu.Customer{},...], 128}
  end
end
