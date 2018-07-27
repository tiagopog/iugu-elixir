defmodule Iugu.Plan do
  @moduledoc """
  Iugu's plan resource
  """

  use Iugu.Resource,
    name: "plans",
    actions: [:list, :show, :delete],
    fields: [
      :name,
      :identifier,
      :interval,
      :interval_type,
      :prices,
      :features
    ]

  @spec show_by_identifier(String.t()) :: Iugu.Request.get_response()
  @doc """
  Returns a Iugu's Plan by identifier

  ## Parameters
    - identifier: Iugu Plan identifier - [Iugu Reference](https://dev.iugu.com/v1.0/reference#testinput-6)
  """
  def show_by_identifier(identifier) do
    %Iugu.Request{path: "plans/identifier/#{identifier}"}
    |> Iugu.Request.get(__MODULE__, :single)
  end
end
