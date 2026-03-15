module PlatformApi
  def self.submit_score(user:, app_slug:, score:, metadata: {})
    app = MiniApp.find_by!(slug: app_slug)
    LeaderboardEntry.create!(
      user: user,
      mini_app: app,
      score: score,
      metadata: metadata,
      achieved_at: Time.current
    )
    ActionCable.server.broadcast(
      "leaderboard_#{app_slug}",
      { action: "new_score", username: user.username, score: score }
    )
    update_high_score(user: user, app: app, score: score)
  end

  def self.leaderboard(app_slug:, limit: 10)
    MiniApp.find_by!(slug: app_slug)
      .leaderboard_entries
      .order(score: :desc)
      .limit(limit)
      .includes(:user)
  end

  def self.save_data(user:, app_slug:, data:)
    app = MiniApp.find_by!(slug: app_slug)
    record = UserAppData.find_or_initialize_by(user: user, mini_app: app)
    record.update!(data: data, last_played_at: Time.current)
  end

  def self.load_data(user:, app_slug:)
    app = MiniApp.find_by!(slug: app_slug)
    UserAppData.find_by(user: user, mini_app: app)&.data || {}
  end

  def self.notify(user:, message:, type: :info)
    # Placeholder — will be implemented with ActionCable or notifications system
    Rails.logger.info("[PlatformApi.notify] user=#{user.id} type=#{type} message=#{message}")
  end

  def self.update_high_score(user:, app:, score:)
    record = UserAppData.find_or_initialize_by(user: user, mini_app: app)
    if score > (record.high_score || 0)
      record.update!(high_score: score)
    end
  end
  private_class_method :update_high_score
end
