defmodule Iugu.Parser do
  @moduledoc """
  TODO
  """

  def parse_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}, schema) do
    body
    |> Poison.Parser.parse(keys: :atoms)
    |> format_result(schema)
  end

  def parse_response({:ok, %HTTPoison.Response{body: body, status_code: 404}}, _schema) do
    {:ok, error} = body |> Poison.Parser.parse(keys: :atoms)
    {:error, error}
  end

  def parse_response({:error, _}), do: {:error, "Error while calling the Iugu's API"}

  def format_result({:ok, %{items: items, totalItems: count}}, schema) do
    items = Enum.map(items, &(struct(schema.__struct__, &1)))
    {:ok, items, count}
  end

  def format_result(_, _), do: {:error, "Can't parse the response"}
end
