Dynamo.under_test(Dyn.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule Dyn.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
