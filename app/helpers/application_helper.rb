# frozen_string_literal: true

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

  def dialect
    session[:dialect]
  end

  def dialect_options
    [%w[Yoda yoda], ['Valley Girl', 'valley_girl'], ['Binary Code', 'binary_code']]
  end
end
