defmodule Iugu.Invoice do
  @moduledoc """
  Iugu's invoice resource
  """

  use Iugu.Resource,
    name: "invoices",
    actions: [:list, :show, :create]
end
