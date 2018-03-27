defmodule Iugu.Parser do
  @moduledoc """
  Parse Iugu's responses into resource structs or errors.
  """

  alias HTTPoison.Response

  @typedoc "Collection or single record parsed from Iugu's API response"
  @type parsed_response :: {:ok, list, integer} | {:ok, struct | map}

  @spec parse_response({:ok, HTTPoison.Response.t}, module, Iugu.Request.cardinality) :: parsed_response
  def parse_response({:ok, %Response{body: body, status_code: 200}}, module, :collection) do
    case body |> Poison.decode(as: %{"items" => [module.__struct__]}) do
      {:ok, %{"items" => items, "totalItems" => count}} -> {:ok, items, count}
      {status, result} -> {status, result}
    end
  end

  def parse_response({:ok, %Response{body: body, status_code: code}}, module, :single) when code in [200, 201] do
    body |> Poison.decode(as: module.__struct__, keys: :atoms)
  end

  def parse_response({:ok, %Response{body: body, status_code: _code}}, _module, _cardinality) do
    body |> Poison.Parser.parse(keys: :atoms)
  end

  @spec parse_response({:error, any}) :: {:error, String.t}
  def parse_response({:error, _}) do
    {:error, "Can't parse the response from Iugu's API"}
  end
end
