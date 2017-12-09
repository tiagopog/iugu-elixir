defmodule Iugu.CommonApi do
  alias Iugu.Config

  def get!(%Config{} = config, parser) do
    HTTPoison.get!(Config.build_url(config), Config.build_headers(config))
    |> parse_response(parser)
  end

  defp parse_response(%HTTPoison.Response{body: body, status_code: 200}, parser) do
    Poison.Parser.parse(body, keys: :atoms) |> build_result(parser)
  end

  defp build_result({:ok, %{items: collection, totalItems: count}}, parser) do
    collection = Enum.map(collection, &parser.from_json/1)
    {:ok, collection, count}
  end

  defp build_result(_, _), do: {:error, "Can't parse the response"}
end
