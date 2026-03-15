module Api
  module V1
    class RegistrationsController < BaseController
      skip_before_action :authenticate_user!, only: :create

      # POST /api/v1/auth/sign_up
      def create
        user = User.new(sign_up_params)
        if user.save
          render json: {
            token: user.generate_jwt,
            user: user_json(user)
          }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def sign_up_params
        params.permit(:username, :email, :password, :password_confirmation)
      end
    end
  end
end
