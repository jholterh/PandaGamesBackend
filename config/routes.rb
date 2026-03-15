Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Auth
      post "auth/sign_in", to: "sessions#create"
      post "auth/sign_up", to: "registrations#create"

      # Current user
      get  "users/me", to: "users#me"
      put  "users/me", to: "users#update_me"

      # Apps
      get  "apps", to: "apps#index"
      get  "apps/:slug", to: "apps#show"

      # Per-app resources
      post "apps/:app_slug/scores", to: "scores#create"
      get  "apps/:app_slug/leaderboard", to: "leaderboards#index"
      get  "apps/:app_slug/data", to: "app_data#show"
      put  "apps/:app_slug/data", to: "app_data#update"
    end
  end

  # Mini-app engines (API-only game logic)
  mount SnakeGame::Engine, at: "/apps/snake-game"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
