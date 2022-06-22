module Api
  module V1
    module Users
      class SessionsController < DeviseTokenAuth::SessionsController
        respond_to :json
        protect_from_forgery with: :null_session

        private

        def resource_params
          params.require(:user).permit(:email, :password)
        end

        def render_create_success
          render json:  { user: resource_data }, status: :created
        end
      end
    end
  end
end
