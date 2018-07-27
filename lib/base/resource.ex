defmodule Iugu.Resource do
  @moduledoc """
  Mixin module to easily include all the common functionality across the resources.
  """

  defmacro __using__(name: resource, actions: actions, fields: fields) do
    quote do
      @derive [Poison.Encoder]
      @resource unquote(resource)
      defstruct unquote([:id, :created_at, :updated_at] ++ fields)
      Module.eval_quoted(__MODULE__, unquote(define_actions(actions)), [], __ENV__)
    end
  end

  @spec define_actions(list) :: list
  @doc false
  def define_actions(actions) do
    actions
    |> Enum.map(fn action -> define_action(action) end)
  end

  @spec define_action(atom) :: {atom, list, list}
  @doc false
  def define_action(:list) do
    quote do
      @spec list(Iugu.Request.t() | map) :: Iugu.Request.get_response()
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

  @doc false
  def define_action(:show) do
    quote do
      @spec show(String.t()) :: Iugu.Request.get_response()
      @doc """
      Returns a #{__MODULE__ |> Atom.to_string() |> String.replace("Elixir.Iugu.", "")}
      """
      def show(id) do
        %Iugu.Request{path: "#{@resource}/#{id}"}
        |> Iugu.Request.get(__MODULE__, :single)
      end
    end
  end

  @doc false
  def define_action(:create) do
    quote do
      @spec create(map) :: Iugu.Request.post_response()
      @doc """
      Creates a #{__MODULE__ |> Atom.to_string() |> String.replace("Elixir.Iugu.", "")}

      ## Parameters
        - data: Map with attributes to create a #{
        __MODULE__ |> Atom.to_string() |> String.replace("Elixir.Iugu.", "")
      }
      """
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
