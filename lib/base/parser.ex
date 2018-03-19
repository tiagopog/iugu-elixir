defmodule Iugu.Parser do
  @moduledoc """
  TODO
  """

  alias HTTPoison.Response

  def parse_response({:ok, %Response{body: body, status_code: 200}}, module, :collection) do
    case body |> Poison.decode(as: %{"items" => [module.__struct__]}, keys: :atoms) do
      {:ok, %{items: items, totalItems: count}} -> {:ok, items, count}
      {status, result} -> {status, result}
    end
  end

  def parse_response({:ok, %Response{body: body, status_code: 200}}, module, :single) do
    body |> Poison.decode(as: module.__struct__, keys: :atoms)
  end

  def parse_response({:ok, %Response{body: body, status_code: code}}, _module, :single) do
    body |> Poison.Parser.parse(keys: :atoms)
  end

  def parse_response({:error, _}) do
    {:error, "Can't parse the response from Iugu's API"}
  end
end
