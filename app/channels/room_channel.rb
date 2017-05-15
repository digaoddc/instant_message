class RoomChannel < ApplicationCable::Channel
  def subscribed
    broadcaster({}).persist_user
    stream_from "room_channel"
  end

  def unsubscribed
    broadcaster({}).unsubscribed
  end

  def speak(data)
    broadcaster(data).speak
  end

  private

  def broadcaster(data)
    RoomsBroadcast.new(data, connection)
  end
end