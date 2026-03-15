require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires username" do
    user = User.new(email: "test@example.com", password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:username], "can't be blank"
  end

  test "requires unique username" do
    user = User.new(username: users(:jakob).username, email: "new@example.com", password: "password123")
    assert_not user.valid?
    assert_includes user.errors[:username], "has already been taken"
  end

  test "has many user_app_data" do
    assert_respond_to users(:jakob), :user_app_data
  end

  test "has many leaderboard_entries" do
    assert_respond_to users(:jakob), :leaderboard_entries
  end
end
