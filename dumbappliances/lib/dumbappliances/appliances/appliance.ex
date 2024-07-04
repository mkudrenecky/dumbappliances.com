defmodule Dumbappliances.Appliances.Appliance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "appliances" do
    field :name, :string
    field :public, :boolean, default: false
    field :category, :string
    field :url, :string
    field :brand, :string
    field :contributor, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(appliance, attrs) do
    appliance
    |> cast(attrs, [:name, :url, :brand, :category, :contributor, :public])
    |> validate_required([:name, :url, :brand, :category, :contributor, :public])
  end
end
