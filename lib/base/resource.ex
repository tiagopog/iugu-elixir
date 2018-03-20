defmodule Iugu.Resource do
  @moduledoc """
  TODO
  """

  defmacro __using__([name: resource, actions: actions]) do
    quote do
      @derive [Poison.Encoder]
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
      @spec list(Iugu.Request.t | map) :: Iugu.Request.get_response
      def list(params \\ %{})

      def list(%Iugu.Request{} = request) do
        %Iugu.Request{request | path: @resource}
        |> Iugu.Request.get(__MODULE__, :collection)
      end

      def list(params) when is_map(params) do
        %Iugu.Request{params: params}
        |> list()
      end
    end
  end

  def define_action(:show) do
    quote do
      @spec show(String.t) :: Iugu.Request.get_response
      def show(id) do
        %Iugu.Request{path: "#{@resource}/#{id}"}
        |> Iugu.Request.get(__MODULE__, :single)
      end
    end
  end

  def define_action(:create) do
    quote do
      @spec create(map) :: Iugu.Request.post_response
      def create(%{} = data) do
        case Poison.encode(data) do
          {:ok, json} ->
            %Iugu.Request{path: @resource, body: json}
            |> Iugu.Request.post(__MODULE__)

          {status, result} ->
            {status, result}
        end
      end
    end
  end

  @spec fields(String.t) :: list
  def fields(resource) do
    Application.get_env(:iugu, String.to_atom(resource))
  end
end
