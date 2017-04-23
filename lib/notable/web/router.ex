defmodule Notable.Web.Router do
  use Notable.Web, :router

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

  scope "/", Notable.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/docs", DocController
  end

  # Other scopes may use custom stacks.a
  scope "/api", Notable.Web do
    pipe_through :api
    resources "/docs", DocController
    resources "/annotations", AnnotationController, except: [:new, :edit]
  end

  forward "/graph", Absinthe.Plug,
    schema: Notable.Schema

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: Notable.Schema
end
