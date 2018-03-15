defmodule Iugu do
  @moduledoc """
  TODO
  """

  import Iugu.Parser
  alias Iugu.Request

  def get(%Request{} = request, resource, schema) do
    Request.build_url(request, resource)
    |> HTTPoison.get(Request.build_headers(request))
    |> parse_response(schema)
  end
end
