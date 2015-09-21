alias ScrabbleCheater.Word

defmodule ScrabbleCheater.Word do
  use ScrabbleCheater.Web, :model

  schema "words" do
    field :name, :string
    field :sorted_name, :string

    timestamps
  end

  def find_matches(letters) do
    from(w in Word,
      where: fragment("sorted_name ~ ?", ^matching_regex(letters)),
      order_by: [desc: fragment("char_length(name)"), asc: w.name])
  end

  defp matching_regex(letters) do
    "^#{split_sort_regex(letters)}?$"
  end

  defp split_sort_regex(letters) do
    letters
    |> String.split("", trim: true)
    |> Enum.reject(&(&1 === " " || &1 === ","))
    |> Enum.sort
    |> Enum.join("?")
  end

  @required_fields ~w(name sorted_name)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
