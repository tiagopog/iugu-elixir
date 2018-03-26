defmodule Iugu.Request do
  @moduledoc """
  Handle request data and call the Iugu's API.
  """

  @domain "https://api.iugu.com"
  @api_version "v1"

  import Application, only: [get_env: 2]

  alias Iugu.{Request,Parser}

  defstruct [
    :api_token,
    :api_key,
    api_version: get_env(:iugu, :api_version) || @api_version,
    domain: get_env(:iugu, :domain) || @domain,
    path: "",
    params: %{},
    body: ""
  ]

  @typedoc "Iugu's request data"
  @type t :: %Iugu.Request{
    api_token: nil | String.t,
    api_key: nil | String.t,
    api_version: nil | String.t,
    domain: nil | String.t,
    path: String.t,
    params: map,
    body: String.t
  }

  @typedoc "Iugu's response for GET endpoints"
  @type get_response :: {:ok, [struct], number} | {:ok, struct | %{errors: String.t}}

  @typedoc "Iugu's response for POST endpoints"
  @type post_response :: {:ok, struct | %{errors: map}}

  @typedoc "Expected data cardinality from response"
  @type cardinality :: :single | :collection

  @spec get(Iugu.Request.t, module, cardinality) :: get_response
  def get(%Request{params: params} = request, module, cardinality) do
    build_url(request)
    |> HTTPoison.get(build_headers(request), params: params)
    |> Parser.parse_response(module, cardinality)
  end

  @spec post(Iugu.Request.t, module) :: post_response
  def post(%Request{body: body} = request, module) do
    build_url(request)
    |> HTTPoison.post(body, build_headers(request))
    |> Parser.parse_response(module, :single)
  end

  @spec build_url(Iugu.Request.t) :: String.t
  defp build_url(%Request{} = request) do
    [request.domain, request.api_version, request.path]
    |> Enum.join("/")
  end

  @spec build_headers(Iugu.Request.t) :: [tuple]
  def build_headers(%Request{api_key: api_key}) do
    basic_token =
      (api_key || get_env(:iugu, :api_key))
      |> generate_basic_token()

    [
      {"Authorization", "Basic #{basic_token}"},
      {"Accept", "application/json; Charset=utf-8"},
      {"Content-Type", "application/json"}
    ]
  end

  @spec generate_basic_token(String.t) :: String.t
  def generate_basic_token(nil),     do: ""
  def generate_basic_token(api_key), do: Base.url_encode64(api_key <> ":", padding: false)
end
