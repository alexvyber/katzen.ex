import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :katzen, KatzenWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "MRoRbUZOngSrnSU7yo2yMGMUy18MVDihTxYiaMiPj2robbZNy1PBWFX9MEQjaNmj",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
