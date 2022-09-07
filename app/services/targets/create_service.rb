module Targets
  class CreateService
    MAX_ALLOWED_TARGETS = 10
    attr_reader :current_user, :params

    def initialize(current_user, params)
      @current_user = current_user
      @params = params
    end

    def call
      raise MaxAllowTargetsError unless targets.count < MAX_ALLOWED_TARGETS

      targets.create!(params)
    end

    private

    def targets
      @targets ||= current_user.targets
    end
  end
end
