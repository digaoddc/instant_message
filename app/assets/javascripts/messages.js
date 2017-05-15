App.messages = App.cable.subscriptions.create('MessagesChannel', {
  connected: function() {
    console.log("Connected to websocket!");
  },
  received: function(data) {
    console.log(data);
    $("#messages-box").append(this.format(data));
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

  sender: function(){
    return $("#username").html();
  },

  dialect: function(){
    return $("#dialect").html();
  },

  display: function(message){
    li = this.speak_li(message);ho
    $("#messages-box").append(li);
  },

});

$(document).ready(function(){
  $( "#send-message" ).click(function() {
    var message = $("#message");
    App.messages.speak(message.val());
    message.val("");
  });
});
