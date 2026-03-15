require "test_helper"

class LeaderboardEntryTest < ActiveSupport::TestCase
  test "requires score" do
    entry = LeaderboardEntry.new(user: users(:jakob), mini_app: mini_apps(:snake_game), achieved_at: Time.current)
    assert_not entry.valid?
    assert_includes entry.errors[:score], "can't be blank"
  end

  test "requires integer score" do
    entry = LeaderboardEntry.new(user: users(:jakob), mini_app: mini_apps(:snake_game), score: 3.5, achieved_at: Time.current)
    assert_not entry.valid?
    assert_includes entry.errors[:score], "must be an integer"
  end
end
