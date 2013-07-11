defmodule Dyn do
  use Application.Behaviour

  @doc """
  The application callback used to start this
  application and its Dynamos.
  """

  def start(_type, _args) do
    pools = [
      {:main_pool,
        [size: 2, max_overflow: 0],
        [
          hostname: '127.0.0.1',
          database: 'tijuanate',
          username: 'postgres'
        ]
      }
    ]

    :application.set_env(:epg_pool, :pools, pools)
    :ok = :application.start(:epg_pool)
    Dyn.Dynamo.start_link([max_restarts: 5, max_seconds: 5])
  end
end
