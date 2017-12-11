defmodule Iugu.CustomerApi do
  @moduledoc """
  Iugu Customer API module
  """

  alias Iugu.{Config,CommonApi,Customer}

  @model Customer
  @resource "customers"

  def list(%Config{} = config, model \\ @model) do
    CommonApi.get!(%Config{config| resource: @resource}, model)
    # {:ok, [%Iugu.Customer{},...], 128}
  end
end
