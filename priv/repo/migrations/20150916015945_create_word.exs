defmodule ScrabbleCheater.Repo.Migrations.CreateWord do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :name, :string
      add :sorted_name, :string

      timestamps
    end
  end
end
