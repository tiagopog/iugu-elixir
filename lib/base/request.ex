defmodule Iugu.Request do
  @moduledoc """
  TODO
  """

  alias Iugu.Request

  defstruct [
    :api_token,
    :api_key,
    domain: "https://api.iugu.com",
    api_version: "v1"
  ]

  def build_url(%Request{} = request, resource) do
    [request.domain, request.api_version, resource]
    |> Enum.join("/")
  end

  def build_headers(%Request{} = request) do
    [
      "Authorization": "Basic #{Request.generate_basic_token(request)}",
      "Accept": "Application/json; Charset=utf-8"
    ]
  end

  def generate_basic_token(%Request{api_key: api_key}) do
    Base.url_encode64(api_key <> ":", padding: false)
  end
end
