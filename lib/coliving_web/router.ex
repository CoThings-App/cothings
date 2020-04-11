defmodule ColivingWeb.Router do
  use ColivingWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ColivingWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/rooms", RoomController
  end

  # Other scopes may use custom stacks.
  # scope "/api", ColivingWeb do
  #   pipe_through :api
  # end
end
