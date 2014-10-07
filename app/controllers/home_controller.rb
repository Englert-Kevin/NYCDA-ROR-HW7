class HomeController < ApplicationController

	def index

		@user = User.find(session[:user_id]) if session[:user_id]
		@posts = @user.posts.all if @user
	end

end