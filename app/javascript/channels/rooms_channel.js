import consumer from "./consumer"

consumer.subscriptions.create("RoomsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    //console.log("Connected to existing rooms channel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    //console.log("Disconnected from existing rooms channel");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    //console.log(data);

    //site will only reload if the site is the one with the existing rooms
    const element = document.getElementById('site-id');
    const site_id = element.getAttribute('data-site-id');

    //console.log("site-id" + site_id);

    if(site_id != null){
      location.reload();
    }
  }
});
