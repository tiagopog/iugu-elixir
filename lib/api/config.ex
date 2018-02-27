defmodule Iugu.Client do
  @moduledoc """
  HTTP client-related functions used as base for calling the Iugu's endpoints
  """

  alias Iugu.Client

  defstruct [
    :resource,
    :api_token,
    :api_key,
    domain: "https://api.iugu.com",
    api_version: "v1"
  ]

  def build_url(%Client{} = client) do
    [client.domain, client.api_version, client.resource]
    |> Enum.join("/")
  end

  def build_headers(%Client{} = client) do
    [
      "Authorization": "Basic #{Client.generate_basic_token(client)}",
      "Accept": "Application/json; Charset=utf-8"
    ]
  end

  def generate_basic_token(%Client{api_key: api_key}) do
    Base.url_encode64(api_key <> ":", padding: false)
  end
end
