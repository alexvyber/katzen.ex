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

    live "/live", Live.Index, :index
    live "/live/modal", Live.Index, :modal

    live "/products", ProductLive.Index, :index
    live "/products/new", ProductLive.Index, :new
    live "/products/:id/edit", ProductLive.Index, :edit
    live "/products/:id", ProductLive.Show, :show
    live "/products/:id/show/edit", ProductLive.Show, :edit

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

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:katzen, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: KatzenWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
