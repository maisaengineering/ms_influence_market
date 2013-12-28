class ApplicationController < ActionController::Base
  protect_from_forgery

  #authenticate user
  def authenticate_user!
  	#session[:user] = nil
  	redirect_to new_session_url and return unless session[:user].present?
  end
end
