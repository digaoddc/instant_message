# frozen_string_literal: true

class RoomsBroadcast
  CHANNEL = 'room_channel'.freeze
  OFFLINE = 'offline'.freeze

  def initialize(data, connection)
    @data = data
    @connection = connection
  end

  def speak
    broadcast_message(data)
  end

  def unsubscribed
    data = {
      from: connection.current_user,
      event: OFFLINE
    }
    broadcast_message(data)
    remove_user
  end

  def persist_user
    redis_client.save_user(connection.current_user)
  end

  private

  attr_reader :data, :connection

  def remove_user
    redis_client.pop(connection.current_user)
  end

  def redis_client
    @redis ||= OnlineStorage.new
  end

  def broadcast_message(data)
    ActionCable.server.broadcast CHANNEL, render_message(data)
  end

  def render_message(data)
    data = data.with_indifferent_access
    {
      from: data['from'],
      event: data['event']
    }
  end
end
