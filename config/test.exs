import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sample_portfolio, SamplePortfolioWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "yWHuTiP8PDCjnBcJr3gGepewv1j2Dx+H5/Yci0k3CTlkowlxEVzRe1uH4avZiz5D",
  server: false

# In test we don't send emails.
config :sample_portfolio, SamplePortfolio.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
