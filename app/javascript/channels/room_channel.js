import consumer from "./consumer"

document.addEventListener('turbolinks:load', () => {

  const element = document.getElementById('room-id');
  const room_id = element.getAttribute('data-room-id');


  consumer.subscriptions.create({channel: "RoomChannel", room: room_id}, {
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

      console.log("Absender ID: " + data.user_id);
      console.log("Nachrichteninhalt: " + data.message);
///////////////////////////
      var ul = document.getElementById("messages_container");
      var li = document.createElement("li");

      li.classList.add('alert');
      li.classList.add('alert-danger');



      li.appendChild(document.createTextNode(data.message));
      ul.appendChild(li);


      //console.log("Name des Senders:" User.find(data.user_id).username);
      //location.reload();
    }
  });
})


