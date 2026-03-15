# frozen_string_literal: true

class LeaderboardComponent < ViewComponent::Base
  def initialize(app_slug:, limit: 10)
    @entries = PlatformAPI.leaderboard(app_slug: app_slug, limit: limit)
  end

  private

  attr_reader :entries
end
