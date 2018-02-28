defmodule Iugu.CustomerApi do
  @moduledoc """
  Iugu Customer API module
  """

  alias Iugu.{Client,CommonApi,Customer}

  @schema Customer
  @resource "customers"

  def list(%Client{} = client, params \\ %{}) do
    CommonApi.get(client, @resource, params, @schema)
  end
end
