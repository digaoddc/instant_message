App.messages = App.cable.subscriptions.create('MessagesChannel', {
  connected: function() {
    console.log("Connected to websocket!");
    return this.perform('appear', {
      from: this.sender()
    });
  },
  received: function(data) {
    console.log(data);
    if(data.action == "speak") {
      $("#messages-box").append(this.format(data));
    } else {
      var msg = this.user_li(data.from);
      $("#active-users").append(msg);
    }
  },

  disconnected: function() {
  },

  speak: function(msg) {
    return this.perform('speak', {
      message: msg,
      from: this.sender(),
      dialect: this.dialect()
    });
  },

  format: function(data) {
    var formatted_msg = data.from + ": " + data.message + " - " + data.time ;
    return(this.speak_li(formatted_msg));
  },

  speak_li: function(message) {
    return "<li class='list-group-item'>" + message + "</li>"
  },

  user_li: function(message) {
    return "<li class='list-group-item online'>" + message + "</li>"
  },

  sender: function(){
    return $("#username").html();
  },

  dialect: function(){
    return $("#dialect").html();
  }

});

$(document).ready(function(){
  $( "#send-message" ).click(function() {
    var message = $("#message");
    App.messages.speak(message.val());
    message.val("");
  });
});
