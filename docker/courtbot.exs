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

# ExTwilio config.
config :ex_twilio,
       # Must be changed
       account_sid: "TWILIO_SID",
         # Must be changed
       auth_token: "TWILIO_TOKEN"

config :rollbax,
       access_token: "ROLLBAR_TOKEN",
       enable_crash_reports: true,
       environment: "production"

config :courtbot, Courtbot,
       locales: %{
         # Must be changed
         "en" => "COURTBOT_NUMBER"
       },
       court_url: "https://mycourts.idaho.gov/",
         # Times are in UTC
         # 5am MST
       import_time: "0 11 * * *",
         # 1pm MSTa
       notify_time: "0 19 * * *",
       importer: %{
         file: "/tmp/test.csv",
         type:
           {:csv,
           [
             {:has_headers, true},
             {:field_mapping,
               [
                 :case_number,
                 :last_name,
                 :first_name,
                 nil,
                 nil,
                 nil,
                 {:date, "%-m/%e/%Y"},
                 {:time, "%k:%M"},
                 nil,
                 :county
               ]}
           ]}
       }

# Import our generated secrets.
# This file is generated
import_config "courtbot.secrets.exs"
