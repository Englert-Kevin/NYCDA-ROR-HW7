class PostsController < ApplicationController

	def index
		@posts = Post.where(user_id: params[:user_id]).all
		@user = User.find(params[:user_id])
	end

	def show
		@post = Post.find(params[:id])
	end

	def new
		@user = User.find(params[:user_id])
		@post = @user.posts.new
	end

	def create
		@user = User.find(params[:user_id])
		@post = @user.posts.new(post_params)
		if @post.save
			flash[:notice] = 'You just posted.'
		else
			flash[:alert] = 'Unable to post.'
		end
		redirect_to user_posts_path @user.id
	end

	def edit
		@user = User.find(params[:user_id])
		@post = @user.posts.find(params[:id])
	end

	def update
		@user = User.find(params[:user_id])
		@post = @user.posts.find(params[:id])
		if @post.update(post_params)
			flash[:notice] = 'Your post is updated.'
		else
			flash[:alert] = 'Unable to update post.'
		end
		redirect_to user_posts_path @post.user.id
	end

	def destroy
		@post = Post.find(params[:id])
		@user = @post.user
		if @post.destroy
			flash[:notice] = 'Post deleted.'
		else
			flash[:alert] = 'Post not deleted.'
		end
		redirect_to user_posts_path @user.id
	end

	private

	def post_params
		params.require(:post).permit(:body)
	end

end