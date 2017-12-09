defmodule Iugu.CustomerApi do
  @moduledoc """
  Iugu Customer API module
  """

  alias Iugu.{Config,CommonApi,Customer}

  @resource "customers"

  def list(%Config{} = config) do
    CommonApi.get!(%Config{config| resource: @resource})
    |> parse_response_body
    # {:ok, [%Iugu.Customer{},...], 128}
  end

  def parse_response_body(%HTTPoison.Response{body: body, status_code: 200}) do
    Poison.decode!(body)
    |> map_array_from_json
  end

  def map_array_from_json(%{"items" => collection, "totalItems" => count}) do
    Enum.map(collection, &Customer.from_json/1)
  end
end
