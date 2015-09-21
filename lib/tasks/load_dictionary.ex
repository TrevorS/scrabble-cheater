alias ScrabbleCheater.Repo
alias ScrabbleCheater.Word

defmodule Mix.Tasks.ScrabbleCheater.Load do
  use Mix.Task

  @shortdoc "Load words into the database"
  @dictionary_path "/usr/share/dict/words"

  def run(_) do
    Repo.start_link
    load_dictionary(@dictionary_path)
  end

  def load_dictionary(path) do
    Repo.delete_all(Word)

    File.read!(path)
    |> String.split
    |> Enum.filter(fn (word) -> String.downcase(word) == word end)
    |> Enum.each(fn (word) -> Repo.insert!(%Word{name: word}) end)
  end
end
