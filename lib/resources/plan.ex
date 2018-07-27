defmodule Iugu.Plan do
  @moduledoc """
  Iugu's plan resource
  """

  use Iugu.Resource,
    name: "plans",
    actions: [:list, :show],
    fields: [
      :name,
      :identifier,
      :interval,
      :interval_type,
      :prices,
      :features
    ]
end
