alias ScrabbleCheater.Repo
alias ScrabbleCheater.Word
alias ScrabbleCheater.Reload, as: R
alias ScrabbleCheater.EctoHelpers, as: EH

import Ecto.Query, only: [from: 2]

defmodule ScrabbleCheater.Reload do
  def reload! do
    Mix.Task.reenable "compile.elixir"
    Application.stop(Mix.Project.config[:app])

    Mix.Task.run "compile.elixir"
    Application.start(Mix.Project.config[:app], :permanent)
  end
end

defmodule ScrabbleCheater.EctoHelpers do
  def all(query) do
    query |> Repo.all
  end

  def find(query, id) do
    query |> Repo.get(id)
  end

  def first(query) do
    from(q in query, order_by: [asc: q.id]) |> from(limit: 1) |> Repo.one
  end

  def last(query) do
    from(q in query, order_by: [desc: q.id]) |> from(limit: 1) |> Repo.one
  end

  def count(query) do
    from(q in query, select: count(q.id)) |> Repo.one
  end

  def inserted_ago(query, number, unit) do
    from(q in query, where: q.inserted_at > datetime_add(^Ecto.DateTime.utc, ^-number, ^to_string(unit))) |> Repo.all
  end

  def updated_ago(query, number, unit) do
    from(q in query, where: q.updated_at > datetime_add(^Ecto.DateTime.utc, ^-number, ^to_string(unit))) |> Repo.all
  end
end
