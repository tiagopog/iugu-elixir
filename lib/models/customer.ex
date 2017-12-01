defmodule Iugu.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Iugu.Customer

  @primary_key false

  embedded_schema do
    field :name, :string
  end

  def changeset(%Customer{} = customer, attrs) do
    customer |> cast(attrs, [:name])
  end
end
