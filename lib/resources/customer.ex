defmodule Iugu.Customer do
  @moduledoc """
  Iugu Customer resource
  """

  use Iugu.Resource, name: "customers"
  alias  Iugu.Request

  def list(%Request{} = request) do
    Iugu.get(request, @resource, __MODULE__)
  end

  def list(params \\ %{}) when is_map(params) do
    %Request{query_params: params}
    |> list()
  end
end
