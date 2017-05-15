App.rooms = App.cable.subscriptions.create('RoomChannel', {
  connected: function() {
    this.speak("online");
  },
  received: function(data) {
    console.log(data);
    if (data.event == "online") {
      this.online(data);
    } else {
      this.offline(data);
    }
  },

  speak: function(event) {
    return this.perform('speak', {
      event: event,
      from: this.sender(),
    });
  },

  online: function(data, msg){
    if ($("#active-users li[data-user='"  + data.from + "']").size() == 0){
      var msg = this.user_li(data.from);
      $("#active-users").append(msg);
    }
  },

  offline: function(data){
    $("#active-users li[data-user='"  + data.from + "']").remove();
  },

  sender: function(){
    return $("#username").html();
  },

  user_li: function(message) {
    return "<li class='list-group-item online' data-user='" + message + "'>" + message + "</li>"
  },
});