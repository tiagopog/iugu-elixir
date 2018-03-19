defmodule Iugu.Request do
  @moduledoc """
  TODO
  """

  import Application, only: [get_env: 2]

  alias Iugu.{Request,Parser}

  defstruct [
    :api_token,
    api_key: get_env(:iugu, :api_key),
    api_version: get_env(:iugu, :api_version),
    domain: get_env(:iugu, :domain),
    path: "",
    params: %{},
    body: %{}
  ]

  def get(%Request{params: params} = request, module, kind) do
    build_url(request)
    |> HTTPoison.get(build_headers(request), params: params)
    |> Parser.parse_response(module, kind)
  end

  def post(%Request{body: body} = request, module) do
    build_url(request)
    |> HTTPoison.post(body, build_headers(request))
    |> Parser.parse_response(module, :single)
  end

  defp build_url(%Request{} = request) do
    [request.domain, request.api_version, request.path]
    |> Enum.join("/")
  end

  defp build_headers(%Request{} = request) do
    [
      "Authorization": "Basic #{generate_basic_token(request)}",
      "Accept": "application/json; Charset=utf-8",
      "Content-Type": "application/json"
    ]
  end

  defp generate_basic_token(%Request{api_key: api_key}) do
    Base.url_encode64(api_key <> ":", padding: false)
  end
end
