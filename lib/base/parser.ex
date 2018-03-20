defmodule Iugu.Parser do
  @moduledoc """
  TODO
  """

  alias HTTPoison.Response

  @spec parse_response({:ok, HTTPoison.Response.t}, module, Iugu.Request.cardinality) ::
          {:ok, list, integer} | {:ok, struct | map}
  def parse_response({:ok, %Response{body: body, status_code: 200}}, module, :collection) do
    case body |> Poison.decode(as: %{"items" => [module.__struct__]}, keys: :atoms) do
      {:ok, %{items: items, totalItems: count}} -> {:ok, items, count}
      {status, result} -> {status, result}
    end
  end

  def parse_response({:ok, %Response{body: body, status_code: 200}}, module, :single) do
    body |> Poison.decode(as: module.__struct__, keys: :atoms)
  end

  def parse_response({:ok, %Response{body: body, status_code: _code}}, _module, :single) do
    body |> Poison.Parser.parse(keys: :atoms)
  end

  @spec parse_response({:error, any}) :: {:error, String.t}
  def parse_response({:error, _}) do
    {:error, "Can't parse the response from Iugu's API"}
  end
end
