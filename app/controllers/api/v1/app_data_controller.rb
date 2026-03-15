module Api
  module V1
    class AppDataController < BaseController
      def show
        data = PlatformAPI.load_data(user: current_user, app_slug: params[:app_slug])
        render json: { data: data }
      end

      def update
        PlatformAPI.save_data(
          user: current_user,
          app_slug: params[:app_slug],
          data: params[:data]&.to_unsafe_h || {}
        )
        render json: { status: "ok" }
      end
    end
  end
end
