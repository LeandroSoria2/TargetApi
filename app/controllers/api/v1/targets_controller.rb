module Api
  module V1
    class TargetsController < Api::V1::ApiController
      def index
        @targets = Target.all
      end

      def create
        @target = current_user.targets.create!(target_params)
      rescue ActiveRecord::RecordInvalid => e
        render json: {
          error: e.to_s
        }, status: :unprocessable_entity
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
        @target ||= Target.find(params[:id])
      end
    end
  end
end
