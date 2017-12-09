defmodule Iugu.Config do
  @moduledoc """
  Holds config data for calling the Iugu's API
  """

  alias Iugu.Config

  defstruct [
    :resource,
    :api_token,
    :api_key,
    domain: "https://api.iugu.com",
    api_version: "v1"
  ]

  def build_url(%Config{} = config) do
    [config.domain, config.api_version, config.resource]
    |> Enum.join("/")
  end

  def build_headers(%Config{} = config) do
    [
      "Authorization": "Basic #{Config.generate_basic_token(config)}",
      "Accept": "Application/json; Charset=utf-8"
    ]
  end

  def generate_basic_token(%Config{api_key: api_key}) do
    Base.url_encode64(api_key <> ":", padding: false)
  end
end
