defmodule ScrabbleCheater.WordTest do
  use ScrabbleCheater.ModelCase

  alias ScrabbleCheater.Word

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Word.changeset(%Word{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Word.changeset(%Word{}, @invalid_attrs)
    refute changeset.valid?
  end
end
