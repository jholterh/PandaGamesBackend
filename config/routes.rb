Rails.application.routes.draw do
  devise_for :users

  root "dashboard#index"

  get "leaderboards/:app_slug", to: "leaderboards#index", as: :leaderboard

  namespace :api do
    namespace :v1 do
      post "apps/:app_slug/scores", to: "scores#create"
      get  "apps/:app_slug/leaderboard", to: "leaderboards#index"
      get  "apps/:app_slug/data", to: "app_data#show"
      put  "apps/:app_slug/data", to: "app_data#update"
    end
  end

  # Mini-app engines
  mount SnakeGame::Engine, at: "/apps/snake-game"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
