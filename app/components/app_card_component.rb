# frozen_string_literal: true

class AppCardComponent < ViewComponent::Base
  def initialize(mini_app:)
    @mini_app = mini_app
  end

  private

  attr_reader :mini_app

  def linkable?
    mini_app.route_prefix.present?
  end
end
