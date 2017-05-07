class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'messages_channel'
  end

  def speak(data)
    ActionCable.server.broadcast "messages_channel", render_message(data)
  end

  private

  def render_message(data)
    puts data.inspect
    {
      message: data['message'],
      from: data['from'],
      time: Time.now.strftime("%D %R")
    }
  end
end
