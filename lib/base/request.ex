defmodule Iugu.Request do
  @moduledoc """
  Handle request data and call the Iugu's API.
  """

  @domain "https://api.iugu.com"
  @api_version "v1"

  import Application, only: [get_env: 2]

  alias Iugu.{Request, Parser}

  defstruct [
    api_token: nil,
    api_key: nil,
    api_version: get_env(:iugu, :api_version) || @api_version,
    domain: get_env(:iugu, :domain) || @domain,
    path: "",
    params: %{},
    body: ""
  ]

  @typedoc "Iugu's request data"
  @type t :: %Iugu.Request{
          api_token: nil | String.t(),
          api_key: nil | String.t(),
          api_version: nil | String.t(),
          domain: nil | String.t(),
          path: String.t(),
          params: map,
          body: String.t()
        }

  @typedoc "Iugu's response for GET endpoints"
  @type get_response :: {:ok, [struct], number} | {:ok, struct | %{errors: String.t()}}

  @typedoc "Iugu's response for POST endpoints"
  @type post_response :: {:ok, struct | %{errors: map}}

  @typedoc "Iugu's response for PUT endpoints"
  @type put_response :: {:ok, struct | %{errors: map}}

  @typedoc "Iugu's response for DELETE endpoints"
  @type delete_response :: {:ok, struct | %{errors: map}}

  @typedoc "Expected data cardinality from response"
  @type cardinality :: :single | :collection

  @spec get(Iugu.Request.t(), module, cardinality) :: get_response
  @doc """
  ## Parameters

    - request: A `%Iugu.Request{}`
    - module: the module to parse the result
    - cardinality: `:single` or `:collection` to parse result as a list or single item
  """
  def get(%Request{params: params} = request, module, cardinality) do
    request
    |> build_url()
    |> HTTPoison.get(build_headers(request), [params: params, timeout: get_env(:iugu, :timeout), recv_timeout: get_env(:iugu, :timeout)])
    |> Parser.parse_response(module, cardinality)
  end

  @spec post(Iugu.Request.t(), module) :: post_response
  @doc """
  ## Parameters

    - request: A `%Iugu.Request{}`
    - module: the module to parse the result
  """
  def post(%Request{body: body} = request, module) do
    request
    |> build_url()
    |> HTTPoison.post(body, build_headers(request), [timeout: get_env(:iugu, :timeout), recv_timeout: get_env(:iugu, :timeout)])
    |> Parser.parse_response(module, :single)
  end

  @spec put(Iugu.Request.t(), module) :: put_response
  @doc """
  ## Parameters

    - request: A `%Iugu.Request{}`
    - module: the module to parse the result
  """
  def put(%Request{body: body} = request, module) do
    request
    |> build_url()
    |> HTTPoison.put(body, build_headers(request), [timeout: get_env(:iugu, :timeout), recv_timeout: get_env(:iugu, :timeout)])
    |> Parser.parse_response(module, :single)
  end

  @spec delete(Iugu.Request.t(), module) :: delete_response
  @doc """
  ## Parameters

    - request: A `%Iugu.Request{}`
    - module: the module to parse the result
  """
  def delete(%Request{} = request, module) do
    request
    |> build_url()
    |> HTTPoison.delete(build_headers(request), [timeout: get_env(:iugu, :timeout), recv_timeout: get_env(:iugu, :timeout)])
    |> Parser.parse_response(module, :single)
  end

  @spec build_url(Iugu.Request.t()) :: String.t()
  defp build_url(%Request{} = request) do
    [request.domain, request.api_version, request.path]
    |> Enum.join("/")
  end

  @spec build_headers(Iugu.Request.t()) :: [tuple]
  defp build_headers(%Request{api_key: api_key}) do
    [
      {"Authorization", "Basic #{generate_basic_token(api_key)}"},
      {"Accept", "application/json; Charset=utf-8"},
      {"Content-Type", "application/json"}
    ]
  end

  @spec generate_basic_token(String.t() | nil) :: String.t()
  defp generate_basic_token(nil) do
    generate_basic_token(get_env(:iugu, :api_key) || "")
  end

  defp generate_basic_token(api_key) when is_binary(api_key) do
    Base.url_encode64(api_key <> ":", padding: false)
  end
end
