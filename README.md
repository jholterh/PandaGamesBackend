# Panda Gang Backend

Rails 8 API serving the [Panda Gang frontend](https://github.com/jholterh/panda-gang-frontend).

## Prerequisites

- Ruby 3.3.3
- PostgreSQL 14+
- Bundler (`gem install bundler`)

## Setup

```bash
bundle install
bin/rails db:create db:migrate db:seed
```

## Starting the server

```bash
bin/rails server
```

This starts the API on **http://localhost:3000** (default Puma port).

### Matching the frontend port

The backend only accepts requests from the origins defined in `FRONTEND_URL`. By default this is `http://localhost:5174` (see `config/initializers/cors.rb`).

Make sure your frontend dev server is actually running on that port. If it runs on a different port (e.g. `5173`), set the env var before starting the backend:

```bash
FRONTEND_URL=http://localhost:5173 bin/rails server
```

To allow multiple frontends at once (e.g. for testing), pass a comma-separated list:

```bash
FRONTEND_URL="http://localhost:5173,http://localhost:5174,http://localhost:5175" bin/rails server
```

On the frontend side, set `VITE_API_URL=http://localhost:3000` so it points at this backend.

## Running tests

```bash
bin/rails test
```

Full CI suite (lint, security audit, tests, seeds):

```bash
bin/ci
```

## Architecture

See [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) for the full system design, database schema, engine pattern, and API routes.
