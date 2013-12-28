class SessionsController < ApplicationController

	#To crate sesstion
	def new
	end

	#authenticating the user
	def create
		if params[:user].downcase == "user" && params[:password].downcase == "password"
			session[:user] = true
			redirect_to root_url
		else
			redirect_to new_session_url, alert: "Something serious happened" 
		end
	end

	def destroy
		session[:user] = nil
		redirect root_url
	end
end
