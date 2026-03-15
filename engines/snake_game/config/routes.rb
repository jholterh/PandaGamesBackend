SnakeGame::Engine.routes.draw do
  root to: "game#show"
  post "score", to: "game#score"
end
