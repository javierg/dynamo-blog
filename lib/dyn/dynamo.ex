defmodule Dyn.Dynamo do
  use Dynamo

  config :dynamo,
    # The environment this Dynamo runs on
    env: Mix.env,

    # The OTP application associated to this Dynamo
    otp_app: :dyn,

    # The endpoint to dispatch requests to
    endpoint: ApplicationRouter,

    # The route from where static assets are served
    # You can turn off static assets by setting it to false
    static_route: "/static"

  # Uncomment the lines below to enable the cookie session store
  # config :dynamo,
  #   session_store: Session.CookieStore,
  #   session_options:
  #     [ key: "_dyn_session",
  #       secret: "f3qTpZ+zQNziZihi9unHJ3n3epCGwG3Ox5B1sgg+Yc3vbVgZU0thNdM2LlPjCvqS"]

  # Default functionality available in templates
  templates do
    use Dynamo.Helpers
    import ViewHelpers
  end
end
