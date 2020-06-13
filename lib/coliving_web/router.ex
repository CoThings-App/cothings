defmodule ColivingWeb.Router do
  use ColivingWeb, :router

  import Phoenix.LiveDashboard.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug ColivingWeb.Plugs.SessionPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :admin_only do
    plug ColivingWeb.Plugs.SessionPlug
    plug ColivingWeb.Plugs.AuthPlug
  end

  scope "/", ColivingWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/privacy", PageController, :privacy
  end

  scope "/", ColivingWeb do
    pipe_through [:browser, :admin_only]

    resources "/rooms", RoomController
    live_dashboard "/dashboard", metrics: ColivingWeb.Telemetry
  end

  scope "/", ColivingWeb do
    pipe_through :api
    get "/config.json", ConfigController, :index
  end

  scope "/session", ColivingWeb do
    pipe_through :browser
    get "/", SessionController, :index
    post "/login", SessionController, :login
    get "/logout", SessionController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", ColivingWeb do
  #   pipe_through :api
  # end
end
