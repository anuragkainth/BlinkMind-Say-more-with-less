class PasswordResetsController < ApplicationController
  # Renders the form to request a password reset
  def new
  end

  # Processes the form submission and sends the reset email
  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      redirect_to login_path, notice: "Password reset instructions have been sent to your email."
    else
      flash.now[:alert] = "Email address not found."
      render :new
    end
  end

  # Renders the form to actually reset the password
  def edit
    # Find the user by the email parameter in the query string
    @user = User.find_by(email: params[:email])
    if @user && valid_user?(@user, params[:id])
      # The user is valid; proceed to render the form.
    else
      redirect_to new_password_reset_path, alert: "Password reset link is invalid or has expired."
    end
  end

  # Processes the password reset form submission
  def update
    @user = User.find_by(email: params[:email])
    if @user && @user.update(user_params)
      redirect_to login_path, notice: "Password has been reset successfully."
    else
      flash.now[:alert] = "There was a problem resetting your password."
      render :edit
    end
  end

  private

  # Checks if the user’s reset token is valid and not expired
  def valid_user?(user, token)
    user.reset_digest.present? &&
      BCrypt::Password.new(user.reset_digest).is_password?(token) &&
      !user.password_reset_expired?
  rescue
    false
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
