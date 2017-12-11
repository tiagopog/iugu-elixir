defmodule Iugu.CommonApi do
  @moduledoc """
  Abstraction to make requests and parse responses to/from Iugu.
  """

  alias Iugu.Config

  def get!(%Config{} = config, model) do
    Config.build_url(config)
    |> HTTPoison.get!(Config.build_headers(config))
    |> parse_response(model)
  end

  defp parse_response(%HTTPoison.Response{body: body, status_code: 200}, model) do
    body
    |> Poison.Parser.parse(keys: :atoms)
    |> format_result(model)
  end

  defp format_result({:ok, %{items: items, totalItems: count}}, model) do
    items = Enum.map(items, &(struct(model.__struct__, &1)))
    {:ok, items, count}
  end

  defp format_result(_, _), do: {:error, "Can't parse the response"}
end
