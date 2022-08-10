module Api
  module V1
    class ApiController < ApplicationController
      include DeviseTokenAuth::Concerns::SetUserByToken
      before_action :authenticate_user!
      protect_from_forgery unless: -> { request.format.json? }
    end
  end
end
