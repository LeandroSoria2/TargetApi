module Api
  module V1
    class ApiController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_user!
      protect_from_forgery unless: -> { request.format.json? }

      rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

      private

      def render_not_found(exception)
        logger.info { exception } # for logging
        render json: { error: I18n.t('api.errors.not_found') }, status: :not_found
      end
    end
  end
end
