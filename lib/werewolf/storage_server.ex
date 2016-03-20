defmodule Werewolf.StorageServer do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
      {:prepend, key, value} ->
        list = Map.get(map, key)
        assert_is_list(list)
        map
        |> Map.put(key, [value | list])
        |> loop
    end
  end

  defp assert_is_list(thing) do
    true = is_list(thing)
  end
end
