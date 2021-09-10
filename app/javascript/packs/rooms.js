console.log("pepe lost");

$(function() {
  $('#new_room_message').on('ajax:success', ()=> {
    console.log("ICH BIN DUMM");
    $(this).find('input[type="text"]').val('');
  });
});

