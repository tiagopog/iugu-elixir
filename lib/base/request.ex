defmodule Iugu.Request do
  @moduledoc """
  TODO
  """

  import Application, only: [get_env: 2]
  alias Iugu.Request

  defstruct [
    :api_token,
    api_key: get_env(:iugu, :api_key),
    api_version: get_env(:iugu, :api_version),
    domain: get_env(:iugu, :domain),
    params: %{}
  ]

  def build_url(%Request{} = request, path) do
    [request.domain, request.api_version, path]
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
