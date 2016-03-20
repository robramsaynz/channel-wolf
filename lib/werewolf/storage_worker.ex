defmodule Werewolf.StorageWorker do
  use GenServer

  def start_link(id) do
    GenServer.start_link(
      __MODULE__,:ok,
      name: {:via, Werewolf.Registry, {:storage_server, id}}
    )
  end

  def init(_) do
    {:ok, []}
  end
end
