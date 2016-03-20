defmodule Player do
  defstruct name: nil, character: nil, lover: false, alive: true

  @roles [:villager, :werewolf, :cupid, :hunter, :seer]

  def new(name) do
    :random.seed(:erlang.now)
    character = Enum.random([:villager, :werewolf, :cupid, :hunter, :seer])
    %Player{name: name, character: character}
  end
end