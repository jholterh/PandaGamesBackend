SnakeGame::Engine.routes.draw do
  post "score", to: "game#score"
end
