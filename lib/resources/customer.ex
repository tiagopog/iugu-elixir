defmodule Iugu.Customer do
  @moduledoc """
  Iugu Customer resource
  """

  use Iugu.Resource,
    name: "customers",
    actions: [:list, :show, :create]
end
