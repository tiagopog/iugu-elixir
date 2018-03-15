# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :iugu,
  api_key: System.get_env("IUGU_API_KEY"),
  api_version: "v1",
  domain: "https://api.iugu.com"

import_config "resources.exs"
