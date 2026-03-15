module Api
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_user!

      private

      def render_error(message, status: :unprocessable_entity)
        render json: { error: message }, status: status
      end

      def user_json(user)
        {
          id: user.id,
          username: user.username,
          email: user.email,
          avatar_url: user.avatar_url,
          total_score: user.total_score
        }
      end
    end
  end
end
