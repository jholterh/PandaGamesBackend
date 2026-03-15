[
  {
    slug: "snake-game",
    name: "Snake Game",
    description: "Classic snake game. Eat, grow, don't crash into yourself!",
    author: "Jakob",
    category: "game",
    tags: %w[arcade solo keyboard],
    route_prefix: "/apps/snake-game",
    version: "0.1.0",
    is_published: true,
    play_count: 42
  },
  {
    slug: "tic-tac-toe",
    name: "Tic-Tac-Toe",
    description: "The timeless two-player classic. X or O — your call.",
    author: "Isa",
    category: "game",
    tags: %w[strategy multiplayer quick],
    route_prefix: "/apps/tic-tac-toe",
    version: "0.1.0",
    is_published: true,
    play_count: 17
  },
  {
    slug: "memory-cards",
    name: "Memory Cards",
    description: "Flip and match pairs. Train your brain, beat the clock.",
    author: "Jakob",
    category: "game",
    tags: %w[puzzle solo memory],
    route_prefix: "/apps/memory-cards",
    version: "0.1.0",
    is_published: true,
    play_count: 8
  }
].each do |attrs|
  MiniApp.find_or_create_by!(slug: attrs[:slug]) do |app|
    app.assign_attributes(attrs)
  end
end

puts "Seeded #{MiniApp.count} mini-apps"
