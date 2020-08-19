$(function() {
  return App.chat = App.cable.subscriptions.create({
    channel: 'ChatChannel',
    id: $('#conversation_id').val()
  }, {
    connected: function() {
  		console.log("Connected to chat channel");
    },
    disconnected: function() {
  		console.log("Disconnected from the chat channel");
    },
    received: function(data) {
  	  var messages = $('#chatbox');
      $('#new_message')[0].reset();
      return $('#chatbox').append(data.message);
    }
  });
});