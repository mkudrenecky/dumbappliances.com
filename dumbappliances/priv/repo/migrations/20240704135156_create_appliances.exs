defmodule Dumbappliances.Repo.Migrations.CreateAppliances do
  use Ecto.Migration

  def change do
    create table(:appliances) do
      add :name, :string
      add :url, :string
      add :brand, :string
      add :category, :string
      add :contributor, :string
      add :public, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
