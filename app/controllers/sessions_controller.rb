class SessionsController < ApplicationController
  def new
    redirect_to home_path, notice: "You are already logged in." if current_user
    # Renders the login form (app/views/sessions/new.html.erb)
  end
  
  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: 'Logged in successfully'
    else
      flash.now[:alert] = "Email or password is invalid"
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: 'Logged out!'
  end
end
