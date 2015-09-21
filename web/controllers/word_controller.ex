defmodule ScrabbleCheater.WordController do
  use ScrabbleCheater.Web, :controller

  def create(conn, %{"word" => %{"letters" => letters}}) do
    words = letters |> matching_words
    count = length(words)

    render(conn, "create.json", words: chunk_words(words), count: count)
  end

  defp matching_words(letters) do
    letters |> Word.find_matches |> Repo.all
  end

  defp chunk_words(words) do
    Enum.chunk_by(words, &(String.length(&1.name)))
  end
end
