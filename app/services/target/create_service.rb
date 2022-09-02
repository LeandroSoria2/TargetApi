module Target
  class CreateService
    MAX_ALLOWED_TARGETS = 10

    def initialize(current_user, params)
      @params = params
      @current_user = current_user
    end

    def call
      raise StandardError unless user_targets_count < MAX_ALLOWED_TARGETS

      Target.create!(params)
    end
  end
end
