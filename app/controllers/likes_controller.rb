class LikesController < ApplicationController
  before_action :require_login

  def create
    @post = Post.find(params[:post_id])
    # Prevent liking if already liked.
    unless @post.likes.exists?(user: current_user)
      @post.likes.create(user: current_user)
    end
    redirect_back fallback_location: home_path
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = @post.likes.find_by(user: current_user)
    like.destroy if like
    redirect_back fallback_location: home_path
  end
end
