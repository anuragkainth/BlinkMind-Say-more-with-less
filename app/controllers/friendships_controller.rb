class FriendshipsController < ApplicationController
  before_action :require_login
  
  def create
    # Sending a friend request from current_user to another user
    friend = User.find(params[:friend_id])
    friendship = current_user.friendships.build(friend: friend)
    if friendship.save
      redirect_back fallback_location: home_path, notice: "Friend request sent."
    else
      redirect_back fallback_location: home_path, alert: "Unable to send friend request."
    end
  end

  def update
    # Accept a friend request: update status from "pending" to "accepted"
    friendship = Friendship.find(params[:id])
    if friendship.update(status: "accepted")
      redirect_back fallback_location: home_path, notice: "Friend request accepted."
    else
      redirect_back fallback_location: home_path, alert: "Unable to accept friend request."
    end
  end

  def destroy
    # Remove a friend or cancel a friend request
    friendship = Friendship.find(params[:id])
    friendship.destroy
    redirect_back fallback_location: home_path, notice: "Friendship removed or request canceled."
  end
end