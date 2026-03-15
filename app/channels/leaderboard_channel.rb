class LeaderboardChannel < ApplicationCable::Channel
  def subscribed
    stream_from "leaderboard_#{params[:app_slug]}"
  end
end
