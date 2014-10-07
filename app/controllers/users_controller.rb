class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@posts = @user.posts.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = 'Welcome to the app.'
			redirect_to user_posts_path @user
		else
			flash[:alert] = 'Count not create new user.'
		end
	end

	def edit
		@user = User.find(session[:user_id]) if session[:user_id]
		
	end

	def update
		@user = User.find(session[:user_id]) if session[:user_id]
		if @user.update(user_params)
			flash[:notice] = 'Profile Updated'
			redirect_to user_path @user
		else
			flash[:alert] = 'Profile update unsuccessful.'
		end
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			session[:user_id] = nil
			flash[:notice] = 'Account deleted.'
		else
			flash[:alert] = 'Account not deleted.'
		end
		redirect_to root_path
	end

	private

	def user_params
		params.require(:user).permit(:username, :email, :password)
	end
end