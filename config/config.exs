# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# The following config keys can be
# app-level overriden if required:
config :iugu,
  api_key: System.get_env("IUGU_API_KEY"),
  api_version: nil,
  domain: nil,
  timeout: 5000
