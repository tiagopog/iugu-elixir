defmodule Iugu.Config do
  @moduledoc """
  Holds config data for calling the Iugu's API
  """

  defstruct [:api_token, :domain, :resource, api_version: "v1"]
end
