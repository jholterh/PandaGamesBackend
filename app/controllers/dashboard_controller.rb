class DashboardController < ApplicationController
  def index
    @mini_apps = MiniApp.published.order(play_count: :desc)
  end
end
