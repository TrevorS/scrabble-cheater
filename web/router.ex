defmodule ScrabbleCheater.Router do
  use ScrabbleCheater.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ScrabbleCheater do
    pipe_through :api # Use the default browser stack

    post "/", WordController, :create
  end
end
