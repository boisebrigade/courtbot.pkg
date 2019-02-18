use Mix.Config

config :courtbot, CourtbotWeb.Endpoint,
  load_from_system_env: false,
  server: true,
  root: ".",
  version: Mix.Project.config()[:version],
  http: [
    port: 4000,
    ip: {0, 0, 0, 0}
  ]

# Database Configuration.
config :courtbot, Courtbot.Repo,
  load_from_system_env: false,
  ssl: false,
  # Must be changed
  url: "POSTGRES_URL",
  pool_size: 10
