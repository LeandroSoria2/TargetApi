class NotificationService
  attr_reader :user, :message, :conversation

  def initialize(user, message)
    @user = user
    @message = message
  end
end
