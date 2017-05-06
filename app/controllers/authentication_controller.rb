class AuthenticationController < ApplicationController
  def signin
    session[:username] = params['username']
    session[:dialect] = params['Dialect']
    redirect_to root_path
  end

  def logout
    session.clear
    flash[:notice] = 'Successfully signed out'
    redirect_to root_path
  end
end