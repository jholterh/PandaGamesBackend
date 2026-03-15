module SnakeGame
  class GameController < ApplicationController
    before_action :authenticate_user!, only: :score

    def show
    end

    def score
      PlatformAPI.submit_score(
        user: current_user,
        app_slug: "snake-game",
        score: params[:score].to_i,
        metadata: { food_eaten: params[:food_eaten].to_i }
      )

      render json: { success: true, score: params[:score].to_i }
    rescue StandardError => e
      render json: { success: false, error: e.message }, status: :unprocessable_entity
    end
  end
end
