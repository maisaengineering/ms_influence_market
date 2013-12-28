
class HomeController < ApplicationController
	#check for the user session
	before_filter :authenticate_user!

	#welcome page after session 
	def index

	end
end
