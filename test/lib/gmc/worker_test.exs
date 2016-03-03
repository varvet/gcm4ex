defmodule GCM.WorkerTest do
  use ExUnit.Case

  @moduletag :capture_log

  setup do
    pool_conf = [env: :dev, key: "some_gcm_api_key", pool_size: 10, pool_max_overflow: 5]
    {:ok, pid} = GCM.Worker.start_link(pool_conf)
    {:ok, pid: pid}
  end

  test "worked handles call", %{pid: pid} do
    message = %GCM.Message{
      notification: %GCM.Message.Loc{body: "goal!"},
      token: "gcm-device-token"
    }
    assert GenServer.call(pid, message) == :ok
  end
end