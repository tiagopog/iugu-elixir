defmodule Iugu.Parser do
  @moduledoc """
  Parse Iugu's responses into resource structs or errors.
  """

  alias HTTPoison.Response

  @typedoc "Collection or single record parsed from Iugu's API response"
  @type parsed_response :: {:ok, list, integer} | {:ok, struct | map}

  @spec parse_response({:ok, HTTPoison.Response.t()}, module, Iugu.Request.cardinality()) ::
          parsed_response
  @doc """


  ## Parameters
    - arg: When JSON is decoded, returns a tuple with {:ok, %Iugu.Response{}}
    - module: module to struct returned json
    - arg3: cardinality(`:single` or `:collection` or ``:direct_collection`) to return a tuple with {:ok, item} or {:ok, list, total_number_of_items}
  """
  def parse_response({:ok, %Response{body: body, status_code: 200}}, module, :collection) do
    case body |> Poison.decode(as: %{"items" => [module.__struct__]}) do
      {:ok, %{"items" => items, "totalItems" => count}} -> {:ok, items, count}
      {status, result} -> {status, result}
    end
  end

  def parse_response({:ok, %Response{body: body, status_code: 200}}, module, :direct_collection) do
    body
    |> Poison.decode(as: [module.__struct__], keys: :atoms)
  end

  def parse_response({:ok, %Response{body: body, status_code: status}}, module, :single)
      when status in [200, 201] do
    body |> Poison.decode(as: module.__struct__, keys: :atoms)
  end

  def parse_response({:ok, %Response{status_code: 500}}, _module, _cardinality) do
    parse_response({:error, 500})
  end

  def parse_response({:ok, %Response{body: body, status_code: _status}}, _module, _cardinality) do
    {:error, Poison.Parser.parse!(body, keys: :atoms)}
  end

  @spec parse_response({:error, HTTPoison.Error.t()}, any, any) :: {:error, String.t()}
  def parse_response({:error, %HTTPoison.Error{reason: reason}}, _module, _cardinality) do
    {:error, reason}
  end

  @spec parse_response({:error, any}) :: {:error, String.t()}
  @doc """
  When JSON can't be decoded a tuple with {:error, _} is returned
  """
  def parse_response({:error, _}) do
    {:error, "Can't parse the response from Iugu's API"}
  end
end
