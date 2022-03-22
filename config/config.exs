# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :spaceflightnewsapi,
  ecto_repos: [Spaceflightnewsapi.Repo]

# Configures the endpoint
config :spaceflightnewsapi, SpaceflightnewsapiWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: SpaceflightnewsapiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Spaceflightnewsapi.PubSub,
  live_view: [signing_salt: "H2keHU/C"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :spaceflightnewsapi, Spaceflightnewsapi.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  level: :debug,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# quantum Scheduler
config :spaceflightnewsapi,Spaceflightnewsapi.Scheduler.JobScheduler,
  jobs: [
    {"0 9 * * *",
    {Spaceflightnewsapi.Routines.Routine, :load_data, []}
    },

    # Test CRON
    # {"* * * * *",
    #   {Spaceflightnewsapi.Routines.Routine, :load_data, []}
    # }
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
