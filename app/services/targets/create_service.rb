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

      Target.transaction do
        target = targets.create!(params)
        find_match(target)
        target
      end
    end

    private

    def targets
      @targets ||= current_user.targets
    end

    def find_match(target)
      compatible_target = compatible_target(target)
      create_match(target, compatible_target) if compatible_target.present?
    end

    def create_match(target, compatible_target)
      Match.create!(target: target, compatible_target: compatible_target)
    end

    def compatible_target(target)
      TargetQuery.new.compatible_target(
        target.radius, target.latitude, target.longitude, target.topic_id, target.user_id
      )
    end
  end
end
