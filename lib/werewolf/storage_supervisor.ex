defmodule Werewolf.StorageSupervisor do
  use Supervisor

  @name Werewolf.StorageSupervisor

  def ensure_running do
    Supervisor.start_child(@name, ["town"])
  end

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def init(:ok) do
    children = [
      worker(Werewolf.StorageWorker, {}, restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end