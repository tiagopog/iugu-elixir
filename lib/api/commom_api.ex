defmodule Iugu.CommonApi do
  @moduledoc """
  Abstraction to make requests and parse responses to/from Iugu.
  """

  alias Iugu.Config

  def get!(%Config{} = config, parser) do
    Config.build_url(config)
    |> HTTPoison.get!(Config.build_headers(config))
    |> parse_response(parser)
  end

  defp parse_response(%HTTPoison.Response{body: body, status_code: 200}, parser) do
    body
    |> Poison.Parser.parse(keys: :atoms)
    |> format_result(parser)
  end

  defp format_result({:ok, %{items: items, totalItems: count}}, parser) do
    items = Enum.map(items, &(struct(parser.__struct__, &1)))
    {:ok, items, count}
  end

  defp format_result(_, _), do: {:error, "Can't parse the response"}
end
