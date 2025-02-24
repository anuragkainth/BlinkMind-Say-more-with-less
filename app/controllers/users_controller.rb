class UsersController < ApplicationController
  before_action :require_login, only: [:show, :edit, :update]
  
  def new
    redirect_to home_path, notice: "You are already logged in." if current_user
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id  # log in the user after signup
      redirect_to home_path, notice: "Signup successful!"
    else
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "Profile updated successfully!"
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :about, :profile_pic)
  end
  
  def require_login
    unless current_user
      redirect_to login_path, alert: "Please log in to continue"
    end
  end
end