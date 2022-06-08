module Api
  module V1
    module Users
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        respond_to :json
        protect_from_forgery with: :null_session

        private

        def sign_up_params
          params.require(:user).permit(:email, :password, :password_confirmation, :gender)
        end

        def render_create_success
          render json: resource_data, status: :created
        end
      end
    end
  end
end
