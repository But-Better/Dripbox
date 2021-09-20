import consumer from "./consumer"

document.addEventListener('turbolinks:load', () =>{

  const element = document.getElementById('room-id');
  const room_id = element.getAttribute('data-room-id');

  consumer.subscriptions.create({channel:"RoomChannel",room: room_id}, {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to room channel: " + room_id);
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log(data);
  }
});
})


