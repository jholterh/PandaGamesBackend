module Api
  module V1
    class LeaderboardsController < BaseController
      skip_before_action :authenticate_user!

      def index
        entries = PlatformAPI.leaderboard(
          app_slug: params[:app_slug],
          limit: (params[:limit] || 10).to_i
        )
        render json: entries.map { |e|
          { rank: nil, username: e.user.username, score: e.score, achieved_at: e.achieved_at }
        }
      end
    end
  end
end
