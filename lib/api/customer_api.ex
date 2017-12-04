defmodule Iugu.CustomerApi do
  alias Iugu.{Config,CommonApi}

  @resource "customers"

  def list(%Config{} = config) do
    CommonApi.get!(%Config{config| resource: @resource})
  end
end
