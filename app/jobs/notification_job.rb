class NotificationJob < ApplicationJob
  attr_reader :user, :message, :conversation

  def match_notification
    MatchNotificationMailer.with(
      user: user
    ).notify.deliver_later
  end
end
