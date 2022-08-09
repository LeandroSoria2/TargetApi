module Api
  module V1
    class TargetsController < Api::V1::ApiController
      def index
        @targets = Target.all
      end

      def create
        @target = current_user.targets.create!(target_params)
      end

      private

      def target_params
        params.require(:target).permit(:title, :radius, :longitude, :latitude, :topic_id)
      end
    end
  end
end
