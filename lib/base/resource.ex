defmodule Iugu.Resource do
  @moduledoc """
  TODO
  """

  defmacro __using__(name: resource) do
    quote do
      @resource unquote(resource)
      defstruct unquote(fields(resource))
    end
  end

  def fields(resource) do
    Application.get_env(:iugu, String.to_atom(resource))
  end
end
