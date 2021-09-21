import consumer from "./consumer"

consumer.subscriptions.create("RoomsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to room creation channel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data);
    location.reload();
  }
});
