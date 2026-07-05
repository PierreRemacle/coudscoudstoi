# coudscoudstoi

A small Rails CRM for tracking sewing/tailoring patrons (customers): patrons, notes on
each patron, marques (brands), and a user profile with session-based auth.

- Rails 8.1.3, Ruby 3.4.5, SQLite (via `solid_cache`/`solid_queue`/`solid_cable`), Puma + Thruster.
- Root route: `patrons#index`. Auth via `sessions` (see `app/controllers/sessions_controller.rb`).

## Local development

```
bin/setup
bin/rails server
```

Needs `config/master.key` (or `RAILS_MASTER_KEY` env var) to decrypt `config/credentials.yml.enc`.
Not in git (see `.gitignore`) — get it from whoever has it saved (currently: the production
server's `.env`, see below).

## Production deployment

Runs on a home server (`pirserver`), **not** via Kamal despite `config/deploy.yml` existing as
unused Rails-generated boilerplate. Actual deployment is `docker-compose.yml` + a dedicated
Cloudflare Tunnel:

- `docker-compose.yml` defines two containers:
  - `web` (`coudscoudstoi_web`) — the Rails app, builds from the repo's `Dockerfile`,
    listens on port 80 internally (Thruster in front of Puma).
  - `cloudflared` (`coudscoudstoi_tunnel`) — a named Cloudflare Tunnel (not a quick tunnel),
    authenticated via `--token`, forwards `coudscoudstoi.com` and `www.coudscoudstoi.com`
    straight to `http://coudscoudstoi_web:80`. No nginx/reverse proxy involved for this app.
  - Both containers share the external `web_gateway` Docker network (also used by the
    other apps on this host) so the tunnel can reach `web` by container name.
- Secrets live in `/home/pir/apps/coudscoudstoi/.env` on the server (git-ignored, never
  committed): `RAILS_MASTER_KEY` and `CLOUDFLARE_TUNNEL_TOKEN`.
- Cloudflare account: `Pierrepierreremacle@gmail.com`. Tunnel name `cloudscloudstoi`,
  tunnel ID `ab160ea0-8ffa-4b5e-a7b7-76e3d2b02ce6`. Domain bought via Namecheap, zone
  added to Cloudflare, MX/TXT records kept for Namecheap email forwarding.

### DNS gotcha (already fixed, but watch for regressions)

When the domain's zone was first added to Cloudflare, it imported the existing Namecheap
parking-page DNS records (`A` on the apex, `CNAME` on `www`) as-is, `Proxied`. Those silently
overrode the tunnel and caused `522`/`525`/`530` errors even though the tunnel's own routing
config was correct. Fix was deleting those records and re-adding the hostnames as
**Public Hostnames on the tunnel** (Cloudflare then creates the correct `Tunnel`-type DNS
record itself). If the site ever starts erroring with a Cloudflare 5xx again, check the DNS
tab for a non-`Tunnel`-type record on the affected hostname before debugging the app or tunnel.

### Auto-deploy on push to main

`.github/workflows/deploy.yml` runs on a **self-hosted GitHub Actions runner installed
directly on `pirserver`** (registered against this repo). On every push to `main` it does,
in place, in the live deploy directory:

```
git fetch origin main
git reset --hard origin/main
docker compose --env-file .env up -d --build
```

Implications:
- Anything pushed to `main` goes live automatically within seconds — no manual deploy step.
- `git reset --hard` means **any uncommitted change made directly on the server will be
  wiped on the next push** — treat `/home/pir/apps/coudscoudstoi` as a deploy target, not a
  place to hand-edit code. `.env` is untouched since it's git-ignored.
- The separate `ci.yml` workflow (Brakeman, bundler-audit, importmap audit, Rubocop) still
  runs on GitHub-hosted `ubuntu-latest` runners for every push/PR — unrelated to deploy.

## Notes for future work on this repo

- `config/deploy.yml` (Kamal) and `.kamal/` are unused leftovers from `rails new` — the app
  is not deployed with Kamal. Safe to ignore or delete if it gets confusing.
- `rails-mockup/` at the repo root looks like a design/prototype directory, not part of the
  running app — check before assuming it's live code.
- No staging environment exists; `main` is production. Consider a feature-branch + PR review
  habit before merging, since merges deploy immediately.

<!-- deploy test: 2026-07-05 -->
