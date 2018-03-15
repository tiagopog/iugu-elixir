defmodule Iugu.Customer do
  @moduledoc """
  Iugu Customer resource
  """

  use Iugu.Resource, name: "customers"
  alias  Iugu.Request


  def list(params \\ %{})

  def list(%Request{} = request) do
    Iugu.get(request, @resource, __MODULE__)
  end

  def list(params) when is_map(params) do
    %Request{params: params}
    |> list()
  end
end
