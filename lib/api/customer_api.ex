defmodule Iugu.CustomerApi do
  @moduledoc """
  Iugu Customer API module
  """

  alias Iugu.{Config,CommonApi,Customer}

  @parser Customer
  @resource "customers"

  def list(%Config{} = config, parser \\ @parser) do
    CommonApi.get!(%Config{config| resource: @resource}, parser)
    # {:ok, [%Iugu.Customer{},...], 128}
  end
end
