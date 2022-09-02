module Targets
  class CreateService
    MAX_ALLOWED_TARGETS = 10
    attr_reader :current_user, :params

    def initialize(current_user, params)
      @params = params
      @current_user = current_user
    end

    def call
      raise MaxAllowTargetsError unless current_user.targets.count < MAX_ALLOWED_TARGETS

      current_user.targets.create!(params)
    end
  end
end
