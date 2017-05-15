class AuthenticationController < ApplicationController
  def signin
    session[:username] = params['username']
    session[:dialect] = params['Dialect']
    cookies.signed[:username] = params['username']
    redirect_to root_path
  end

  def logout
    session.clear
    flash[:notice] = 'Successfully signed out'
    cookies.delete(:username)
    redirect_to root_path
  end
end