require "test_helper"

class MiniAppTest < ActiveSupport::TestCase
  test "requires slug" do
    app = MiniApp.new(name: "Test")
    assert_not app.valid?
    assert_includes app.errors[:slug], "can't be blank"
  end

  test "requires unique slug" do
    app = MiniApp.new(slug: mini_apps(:snake_game).slug, name: "Duplicate")
    assert_not app.valid?
    assert_includes app.errors[:slug], "has already been taken"
  end

  test "published scope returns only published apps" do
    published = MiniApp.published
    assert published.all?(&:is_published)
    assert_not_includes published, mini_apps(:unpublished_app)
  end
end
