defmodule Iugu.Parser do
  @moduledoc """
  TODO
  """

  def parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}, module) do
    body
    |> Poison.Parser.parse(keys: :atoms)
    |> format_result(module)
  end

  def parse_response({:ok, %HTTPoison.Response{body: body, status_code: 404}}, _module) do
    {:ok, error} = body |> Poison.Parser.parse(keys: :atoms)
    {:error, error}
  end

  def parse_response({:error, _}), do: {:error, "Error while calling the Iugu's API"}

  def format_result({:ok, %{items: items, totalItems: count}}, module) do
    items = Enum.map(items, &(struct(module.__struct__, &1)))
    {:ok, items, count}
  end

  def format_result(_, _), do: {:error, "Can't parse the response"}
end
