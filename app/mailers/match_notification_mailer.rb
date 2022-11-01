class MatchNotificationMailer < ApplicationMailer
  def send_match_email(user)
    @user = user
    mail(to: @user.email,
         subject: @message)
  end
end
