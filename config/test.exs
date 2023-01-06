import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :foodtrucks, FoodtrucksWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "wZLF6MxKxwsy/5ebE0wcz7L3gcPXkb6m/CckbE2iIj52FV6w5962oLbTIk8hXGz4",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
