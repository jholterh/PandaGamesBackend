module Api
  module V1
    class AppDataController < BaseController
      def show
        data = PlatformApi.load_data(user: current_user, app_slug: params[:app_slug])
        render json: { data: data }
      end

      def update
        PlatformApi.save_data(
          user: current_user,
          app_slug: params[:app_slug],
          data: params[:data]&.to_unsafe_h || {}
        )
        render json: { status: "ok" }
      end
    end
  end
end
