# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :dxpress,
  ecto_repos: [Dxpress.Repo]

# Configures the endpoint
config :dxpress, DxpressWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "guYJler+Vj1dK+PWQ1of0CJFM8lrEev4gn2u8/JwAkDxOxVfKKhtM3dq8doCZpWL",
  render_errors: [view: DxpressWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Dxpress.PubSub,
  live_view: [signing_salt: "eFogN7iP"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
