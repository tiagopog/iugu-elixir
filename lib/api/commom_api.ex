defmodule Iugu.CommonApi do
  alias Iugu.Config

  def get!(%Config{} = config) do
    HTTPoison.get!(Config.build_url(config), Config.build_headers(config))
  end
end
