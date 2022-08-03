module Api
  module V1
    class ApiController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_user!
      respond_to :json
      protect_from_forgery with: :null_session
    end
  end
end
