defmodule ScrabbleCheater.Repo.Migrations.CreateWord do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :value, :string

      timestamps
    end

  end
end
