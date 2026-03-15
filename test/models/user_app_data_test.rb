require "test_helper"

class UserAppDataTest < ActiveSupport::TestCase
  test "enforces unique user-app pair" do
    existing = user_app_data(:jakob_snake)
    duplicate = UserAppData.new(user: existing.user, mini_app: existing.mini_app)
    assert_not duplicate.valid?
    assert_includes duplicate.errors[:user_id], "has already been taken"
  end
end
