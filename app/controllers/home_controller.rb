class HomeController < ApplicationController
  def index
    @users = redis_client.users
  end

  private

  def redis_client
    OnlineStorage.new
  end
end