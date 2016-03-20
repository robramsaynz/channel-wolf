// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

import socket from "./socket"

// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("rooms:lobby", {})

document.join_game = () => {
  channel.push("join_game", {username: $('#username').val()})
}

document.start_game = () => {
  channel.push("start_game", {})
}

channel.on("update_page", payload => {
  $('main').html(payload.page)
})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })
