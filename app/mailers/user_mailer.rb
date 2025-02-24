class UserMailer < ApplicationMailer
  default from: 'no-reply@catchupapp.com'

  def password_reset(user)
    @user = user
    @reset_url = edit_password_reset_url(@user.reset_token, email: @user.email)
    mail to: @user.email, subject: "Password Reset Instructions"
  end
end
