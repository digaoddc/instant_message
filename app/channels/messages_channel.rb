# frozen_string_literal: true

class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'messages_channel'
  end

  def speak(data)
    MessagesBroadcaster
      .new(data)
      .execute
  end
end
