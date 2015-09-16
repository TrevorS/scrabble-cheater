alias ScrabbleCheater.Word

defmodule ScrabbleCheater.Word do
  use ScrabbleCheater.Web, :model

  schema "words" do
    field :value, :string

    timestamps
  end

  def find_matches(permutations) do
    from w in Word, where: w.value in ^permutations
  end

  @required_fields ~w(value)
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
