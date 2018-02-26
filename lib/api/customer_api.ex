defmodule Iugu.CustomerApi do
  @moduledoc """
  Iugu Customer API module
  """

  alias Iugu.{Config,CommonApi,Customer}

  @schema Customer
  @resource "customers"

  def list(%Config{} = config, schema \\ @schema) do
    CommonApi.get!(%Config{config| resource: @resource}, schema)
    # {:ok, [%Iugu.Customer{},...], 128}
  end
end
