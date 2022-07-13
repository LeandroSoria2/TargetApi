module Api
  module V1
    class TopicsController < ApplicationController
      def index
        @topics = Topic.all
      end
    end
  end
end
