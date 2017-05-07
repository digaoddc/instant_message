App.messages = App.cable.subscriptions.create('MessagesChannel', {
  connected: function() {
    console.log("Connected");
  },
  received: function(data) {
    console.log(data);
    $("#messages-box").append(this.format(data));
  },

  disconnected: function() {
  },

  speak: function(msg) {
    return this.perform('speak', {
      message: msg,
      from: this.sender()
    });
  },

  format: function(data) {
    var formatted_msg = data.from + ": " + data.message + " - " + data.time ;
    return "<li class='list-group-item'>" + formatted_msg + "</li>"
  },

  sender: function(){
    return $("#username").html();
  }
});

$(document).ready(function(){
  $( "#send-message" ).click(function() {
    var message = $("#message");
    App.messages.speak(message.val());
    message.val("");
  });
});
