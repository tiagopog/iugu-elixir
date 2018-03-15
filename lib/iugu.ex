defmodule Iugu do
  @moduledoc """
  TODO
  """

  alias Iugu.{Parser,Request}

  def get(%Request{params: params} = request, resource, module) do
    Request.build_url(request, resource)
    |> HTTPoison.get(Request.build_headers(request), params: params)
    |> Parser.parse_response(module)
  end
end
