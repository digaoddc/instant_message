# frozen_string_literal: true

class OnlineStorage
  COLLECTION = 'user'

  def initialize(conn = Redis.new(host: RedisConfig.host))
    @conn = conn
  end

  def save_user(user)
    conn.sadd COLLECTION, user
  end

  def users
    conn.smembers COLLECTION
  end

  def pop(user)
    conn.srem COLLECTION, user
  end

  def clear
    conn.spop COLLECTION, 100
  end

  private

  attr_reader :conn
end
