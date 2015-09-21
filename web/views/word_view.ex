alias ScrabbleCheater.WordView

defmodule ScrabbleCheater.WordView do
  use ScrabbleCheater.Web, :view

  def render("create.json", %{words: words, count: count}) do
    %{meta: meta(count), data: render_many(words, WordView, "words.json")}
  end

  def render("words.json", %{word: words}) do
    Map.put(%{}, chunk_length(words), render_many(words, WordView, "word.json"))
  end

  def render("word.json", %{word: word}) do
    %{name: word.name}
  end

  defp meta(count) do
    %{count: count, timestamp: Ecto.DateTime.utc}
  end

  defp chunk_length(words) do
    words |> hd |> Map.get(:name) |> String.length |> to_string
  end
end
