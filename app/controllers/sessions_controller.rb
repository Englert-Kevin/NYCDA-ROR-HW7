class SessionsController < ApplicationController

	def create
		@user = User.where(username: params[:username]).first
		if @user && @user.password == params[:password]
			session[:user_id] = @user.id
			flash[:notice] = 'You are signed in.'
			redirect_to	root_path
		else
			flash[:alert] = 'Sign-in not successful.'
			redirect_to root_path
		end
	end

	def new
		
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end

end