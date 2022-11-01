class NotificationService
  attr_reader :user, :message, :conversation

  def initialize(user, message)
    @user = user
    @message = message
  end

  def match_notification
    MatchNotificationMailer.with(
      user: user
    ).notify.deliver_later
  end
end
