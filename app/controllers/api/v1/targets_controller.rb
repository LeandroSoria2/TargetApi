module Api
  module V1
    class TargetsController < Api::V1::ApiController
      def index
        @targets = Target.all
      end

      def create
        @target = current_user.targets.create!(target_params)
      end

      def destroy
        target.destroy!
        head :no_content
      rescue ActiveRecord::RecordNotFound => e
        render json: {
          error: e.to_s
        }, status: :not_found
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
