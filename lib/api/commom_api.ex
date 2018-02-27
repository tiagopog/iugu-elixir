defmodule Iugu.CommonApi do
  @moduledoc """
  Abstraction for making requests and parsing responses to/from Iugu.
  """

  alias Iugu.Client

  def get!(%Client{} = client, schema) do
    Client.build_url(client)
    |> HTTPoison.get!(Client.build_headers(client))
    |> parse_response(schema)
  end

  defp parse_response(%HTTPoison.Response{body: body, status_code: 200}, schema) do
    body
    |> Poison.Parser.parse(keys: :atoms)
    |> format_result(schema)
  end

  defp format_result({:ok, %{items: items, totalItems: count}}, schema) do
    items = Enum.map(items, &(struct(schema.__struct__, &1)))
    {:ok, items, count}
  end

  defp format_result(_, _), do: {:error, "Can't parse the response"}
end
