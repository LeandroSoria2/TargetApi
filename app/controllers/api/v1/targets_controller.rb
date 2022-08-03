module Api
  module V1
    class TargetsController < Api::V1::ApiController
      def index
        @targets = Target.all
        render json: @targets
      end

      def create
        @target = current_user.targets.create!(target_params)
        if @target.save
          render json: { success: true, target: @target }
        else
          render json: { success: false }
        end
      end

      def destroy
        if @target.find(params[:id]).destroy!
          render json: { success: true }
        else
          render json: { success: false }
        end
      end

      private

      def target_params
        params.require(:target).permit(:title, :radius, :longitude, :latitude, :topic_id)
      end
    end
  end
end
