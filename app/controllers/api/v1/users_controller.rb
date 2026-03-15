module Api
  module V1
    class UsersController < BaseController
      # GET /api/v1/users/me
      def me
        render json: { user: user_json(current_user) }
      end

      # PUT /api/v1/users/me
      def update_me
        if current_user.update(profile_params)
          render json: { user: user_json(current_user) }
        else
          render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def profile_params
        params.permit(:username, :avatar_url)
      end
    end
  end
end
