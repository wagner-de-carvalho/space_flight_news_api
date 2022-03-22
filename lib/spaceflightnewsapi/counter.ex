defmodule  Spaceflightnewsapi.Counter do
  use Agent
  require Logger

  def start_link(_initial_value) do
    Agent.start_link(fn -> %{limit: 2, offset: 0} end, name: __MODULE__)
    Logger.info("Counter started!")
  end

  def value do
    Agent.get(__MODULE__, & &1)
  end

  def increment do
    Agent.update(__MODULE__, fn e ->
      e
      |> Map.put(:limit, e.limit + 2)
      |> Map.put(:offset, e.offset + 2)
    end)
  end

  def reset do
    Agent.update(__MODULE__, fn e ->
      e
      |> Map.put(:limit, 2)
      |> Map.put(:offset, 0)
    end)
  end
end
