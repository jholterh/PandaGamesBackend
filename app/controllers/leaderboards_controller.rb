class LeaderboardsController < ApplicationController
  def index
    @mini_app = MiniApp.find_by!(slug: params[:app_slug])
    @entries = PlatformAPI.leaderboard(app_slug: params[:app_slug], limit: 20)
  end
end
