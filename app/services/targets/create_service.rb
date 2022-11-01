module Targets
  class CreateService
    MAX_ALLOWED_TARGETS = 10
    attr_reader :current_user, :target_attributes

    def initialize(current_user, target_attributes)
      @current_user = current_user
      @target_attributes = target_attributes
    end

    def call
      raise MaxAllowTargetsError unless targets.count < MAX_ALLOWED_TARGETS

      Target.transaction do
        target = targets.create!(target_attributes)
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
      [target, compatible_target].each do |target_to_update|
        target_to_update.update!(matched: true)
      end
      notification(target.user)
    end

    def compatible_target(target)
      TargetQuery.new.compatible_target(target)
    end

    def notification(user)
      NotificationService.send_match_email(user).deliver
    end
  end
end
