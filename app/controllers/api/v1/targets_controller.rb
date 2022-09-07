module Api
  module V1
    class TargetsController < Api::V1::ApiController
      def index
        @targets = Target.all
      end

      def create
        @target = Targets::CreateService.new(current_user, target_params).call
      rescue MaxAllowTargetsError
        head :unprocessable_entity
      end

      def destroy
        target.destroy!
        head :no_content
      end

      private

      def target_params
        params.require(:target).permit(:title, :radius, :longitude, :latitude, :topic_id)
      end

      def target
        @target ||= current_user.targets.find(params[:id])
      end
    end
  end
end
