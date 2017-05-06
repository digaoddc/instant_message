module ApplicationHelper
  def logged?
    session[:username].present? && session[:dialect].present?
  end

  def home_partial
    logged? ? 'user' : 'visitor'
  end

  def username
    session[:username]
  end
end
