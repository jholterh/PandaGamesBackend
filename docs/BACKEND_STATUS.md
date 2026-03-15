# Backend Status — What's Built So Far

**Last updated:** 2026-03-15
**Branch:** `emdash/feat-setup-2sh` ([PR #6](https://github.com/jholterh/PandaGamesBackend/pull/6))

---

## Authentication (Devise)

Users register with **username**, **email**, and **password**.

| Route | What it does |
|-------|-------------|
| `GET /users/sign_up` | Registration (includes username field) |
| `GET /users/sign_in` | Login |
| `DELETE /users/sign_out` | Logout (use `data-turbo-method: :delete`) |
| `GET /users/password/new` | Forgot password |
| `GET /users/edit` | Edit profile (username, email, password) |

All views are custom Tailwind — not Devise defaults. Session is cookie-based, so Turbo and ActionCable pick it up automatically.

**Helpers available in views:**
- `user_signed_in?` — boolean
- `current_user` — the logged-in `User` record (has `.username`, `.email`, `.avatar_url`, `.total_score`)
- `authenticate_user!` — before_action to require login

---

## Database Schema

### `users`
| Column | Type | Notes |
|--------|------|-------|
| `username` | string | unique, required, max 50 chars |
| `email` | string | unique, required (Devise) |
| `avatar_url` | string | nullable, not used in views yet |
| `total_score` | integer | default 0, not auto-updated yet |

### `mini_apps`
| Column | Type | Notes |
|--------|------|-------|
| `slug` | string | unique, e.g. `"snake-game"` |
| `name` | string | display name |
| `description` | text | |
| `author` | string | |
| `category` | string | `"game"`, `"tool"`, `"utility"` |
| `tags` | text[] | postgres array, e.g. `["arcade", "solo"]` |
| `thumbnail_url` | string | nullable |
| `route_prefix` | string | e.g. `"/apps/snake-game"` |
| `version` | string | |
| `is_published` | boolean | default false |
| `play_count` | integer | default 0 |

### `user_app_data`
Per-user, per-app flexible storage. Unique on `[user_id, mini_app_id]`.

| Column | Type | Notes |
|--------|------|-------|
| `user_id` | FK → users | |
| `mini_app_id` | FK → mini_apps | |
| `data` | jsonb | any app-specific data |
| `high_score` | integer | default 0 |
| `play_count` | integer | default 0 |
| `last_played_at` | datetime | |

### `leaderboard_entries`
| Column | Type | Notes |
|--------|------|-------|
| `mini_app_id` | FK → mini_apps | |
| `user_id` | FK → users | |
| `score` | integer | required |
| `metadata` | jsonb | level, mode, etc. |
| `achieved_at` | datetime | required |

Indexed on `[mini_app_id, score DESC]` for fast leaderboard queries.

---

## API Endpoints

All API routes are under `/api/v1/apps/:app_slug/`. All except leaderboard require authentication (return 401 if not signed in).

### Submit Score
```
POST /api/v1/apps/:app_slug/scores
Body: { score: 150, metadata: { level: 3 } }
Response: 201 Created — the LeaderboardEntry JSON
```

### Get Leaderboard (public)
```
GET /api/v1/apps/:app_slug/leaderboard?limit=10
Response: [{ rank: null, username: "jakob", score: 250, achieved_at: "..." }, ...]
```

### Load App Data
```
GET /api/v1/apps/:app_slug/data
Response: { data: { level: 3, ... } }
```

### Save App Data
```
PUT /api/v1/apps/:app_slug/data
Body: { data: { level: 3, settings: { sound: true } } }
Response: { status: "ok" }
```

---

## PlatformAPI Service

Engines (and any backend code) should use `PlatformAPI` instead of hitting models directly:

```ruby
PlatformAPI.submit_score(user:, app_slug:, score:, metadata: {})
PlatformAPI.leaderboard(app_slug:, limit: 10)
PlatformAPI.save_data(user:, app_slug:, data:)
PlatformAPI.load_data(user:, app_slug:)
PlatformAPI.notify(user:, message:, type:)  # logs only for now
```

`submit_score` also broadcasts to ActionCable (see below).

---

## ActionCable — Live Leaderboard

When a score is submitted, the backend broadcasts to:
```
Channel: LeaderboardChannel
Stream: "leaderboard_#{app_slug}"
Payload: { action: "new_score", username: "jakob", score: 250 }
```

**Frontend TODO:** No JavaScript consumer exists yet. To subscribe:
```javascript
consumer.subscriptions.create(
  { channel: "LeaderboardChannel", app_slug: "snake-game" },
  { received(data) { /* update leaderboard UI */ } }
)
```

Connection identifies `current_user` via Devise/warden but does **not** reject unauthenticated connections (so anonymous users can watch leaderboards).

---

## Pages & Views

| URL | Controller | What's there |
|-----|-----------|-------------|
| `/` | `DashboardController#index` | Grid of published mini-apps using `AppCardComponent` |
| `/leaderboards/:app_slug` | `LeaderboardsController#index` | Scores table using `LeaderboardComponent` |
| `/apps/snake-game` | `SnakeGame::GameController#show` | Playable canvas snake game |

### ViewComponents
| Component | Usage |
|-----------|-------|
| `AppCardComponent.new(mini_app:)` | Card with thumbnail/placeholder, name, description, author, play count. Links to `route_prefix` if set. |
| `LeaderboardComponent.new(app_slug:, limit: 10)` | Fetches and renders ranked scores table with empty state. |

---

## Snake Game Engine

Mounted at `/apps/snake-game`. First real engine — proves out the pattern.

- Canvas-based, Stimulus controller inlined in the view
- Arrow key controls, snake grows on food, speed increases
- On game over: POSTs score to `/apps/snake-game/score` (engine route)
- Score submission requires auth — shows "Sign in to save" if not logged in
- Links back to dashboard via `main_app.root_path`

---

## Engine Template

Copy `engines/_template/` to create a new engine. Structure:
```
engines/_template/
├── app/controllers/
├── app/models/
├── app/views/
├── app/javascript/
├── config/routes.rb
├── lib/_template.rb
├── lib/_template/engine.rb
├── manifest.json
└── _template.gemspec
```

After copying, update the module name, gemspec, manifest.json, add to `Gemfile` (`gem "your_app", path: "engines/your_app"`), and mount in `config/routes.rb`.

---

## Seeds

3 mini-apps are seeded (run `bin/rails db:seed`):
- **Snake Game** — published, has engine
- **Tic-Tac-Toe** — published, no engine yet
- **Memory Cards** — published, no engine yet

---

## What's NOT Built Yet

- **No avatar upload** — `avatar_url` column exists but nothing sets it
- **No `total_score` aggregation** — column exists, not auto-updated
- **No profile page** — Devise edit exists at `/users/edit` but no link in nav
- **No mobile nav** — navbar is desktop-only flex row
- **No notification system** — `PlatformAPI.notify` just logs
- **No frontend ActionCable consumer** — broadcasts happen but nothing listens
- **Tic-Tac-Toe / Memory Cards engines** — seeded but not built
- **No ViewComponents for:** GameOverModal, ScoreDisplay, Notification
