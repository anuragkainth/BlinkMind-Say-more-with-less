class PostsController < ApplicationController
  before_action :require_login

  def index
    friend_ids = current_user.all_friends.map(&:id)
    @posts = Post.where(user_id: [current_user.id] + friend_ids).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to home_path, notice: "Post shared successfully!"
    else
      flash.now[:alert] = "There was an error sharing your post."
      render :new
    end
  end

  def delete
    @post = Post.find(params[:id]) # Find the post by ID
    if @post.destroy # Destroy the post
      redirect_to home_path, notice: "Post deleted successfully!" # Redirect with success message
    else
      flash.now[:alert] = "There was an error deleting your post." # Error message
      render :index # Render index if there's an error
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end