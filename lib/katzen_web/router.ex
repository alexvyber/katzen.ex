defmodule KatzenWeb.Router do
  use KatzenWeb, :router
  import PhoenixStorybook.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {KatzenWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KatzenWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/" do
    storybook_assets()
  end

  scope "/", KatzenWeb do
    pipe_through(:browser)
    live_storybook("/storybook", backend_module: KatzenWeb.Storybook)
  end

  # Other scopes may use custom stacks.
  # scope "/api", KatzenWeb do
  #   pipe_through :api
  # end
end
