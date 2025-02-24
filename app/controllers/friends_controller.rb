class FriendsController < ApplicationController
  before_action :require_login
  
  def index
    # Display all confirmed friends
    @friends = current_user.all_friends
  end
  
  def pending
    # Display friend requests received (pending)
    @pending_requests = current_user.pending_friend_requests
  end
  
  def search
    # Search for members by name or email
    if params[:query].present?
      query = params[:query]
      @users = User.where("name LIKE ? OR email LIKE ?", "%#{query}%", "%#{query}%")
                 .where.not(id: current_user.id)
    else
      @users = []
    end
  end
end
