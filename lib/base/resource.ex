defmodule Iugu.Resource do
  @moduledoc """
  TODO
  """

  defmacro __using__([name: resource, actions: actions]) do
    quote do
      @resource unquote(resource)
      defstruct unquote(fields(resource))
      Module.eval_quoted(__MODULE__, unquote(define_actions(actions)), [], __ENV__)
    end
  end

  def define_actions(actions) do
    actions
    |> Enum.map(fn(action) -> define_action(action) end)
  end

  def define_action(:list) do
    quote do
      def list(params \\ %{})

      def list(%Iugu.Request{} = request) do
        Iugu.get(request, @resource, __MODULE__)
      end

      def list(params) when is_map(params) do
        %Iugu.Request{params: params}
        |> list()
      end

      defoverridable [list: 1]
    end
  end

  def define_action(:show) do
    quote do
      def show(id) do
        %Iugu.Request{params: %{id: id}}
        |> Iugu.get("#{@resource}/#{id}", __MODULE__)
      end
    end
  end

  def fields(resource) do
    Application.get_env(:iugu, String.to_atom(resource))
  end
end
