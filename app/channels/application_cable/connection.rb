module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_user
    end

    private

    def find_user
      user = cookies.signed[:username]

      if user.present?
        user
      else
        reject_unauthorized_connection
      end
    end
  end
end
