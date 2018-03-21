defmodule Iugu.Customer do
  @moduledoc """
  Iugu's customer resource
  """

  use Iugu.Resource,
    name: "customers",
    actions: [:list, :show, :create]
end
