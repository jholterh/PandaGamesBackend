module Api
  module V1
    class ScoresController < BaseController
      def create
        entry = PlatformApi.submit_score(
          user: current_user,
          app_slug: params[:app_slug],
          score: params[:score].to_i,
          metadata: params[:metadata] || {}
        )
        render json: entry, status: :created
      end
    end
  end
end
