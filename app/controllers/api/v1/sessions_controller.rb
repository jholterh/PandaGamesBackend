module Api
  module V1
    class SessionsController < BaseController
      skip_before_action :authenticate_user!, only: :create

      # POST /api/v1/auth/sign_in
      def create
        user = User.find_by(email: params[:email])
        if user&.valid_password?(params[:password])
          render json: {
            token: user.generate_jwt,
            user: user_json(user)
          }
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end
    end
  end
end
