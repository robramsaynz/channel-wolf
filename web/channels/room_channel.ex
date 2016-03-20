defmodule Werewolf.RoomChannel do
  use Phoenix.Channel

  def join("rooms:lobby", _message, socket) do
    {:ok, pid} = Werewolf.StorageServer.start_link
    Process.register(pid, :store)

    send :store, {:put, :users, ["jeff", "helen", "mel", "hugh"]}

    {:ok, socket}
  end
  def join("rooms:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("join_game", %{"username" => username}, socket) do
    send :store, {:prepend, :users, username}

    {:safe, page} = Werewolf.PageView.render("card.html")
    broadcast! socket, "update_page", %{page: to_string(page)}
    {:noreply, socket}
  end

  def handle_in("start_game", _, socket) do
    send :store, {:get, :users, self()}
    receive do
      users -> users = users
    end

    {:safe, page} = Werewolf.PageView.render("cupid.html", users: users)
    broadcast! socket, "update_page", %{page: to_string(page)}
    {:noreply, socket}
  end

  def handle_out("update_page", payload, socket) do
    push socket, "update_page", payload
    {:noreply, socket}
  end
end