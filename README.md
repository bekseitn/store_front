### Storefront

A small online store: product catalog with search/price filtering, a session-based cart,
and checkout. Admin panel: `/admin` (HTTP Basic Auth — see `RAILS_ADMIN_USERNAME`/
`RAILS_ADMIN_PASSWORD` below).

* * *

#### Backend

1.  Ruby 3.4
2.  Rails 8.0
3.  PostgreSQL

#### Frontend

1.  Haml
2.  Bootstrap 5.3
3.  Hotwire (Turbo + Stimulus, via importmap-rails)

#### Testing

1.  RSpec + FactoryBot (`spec/`)
2.  rubocop (`bundle exec rubocop`)

#### Other notable gems

* `rails_admin` — admin panel at `/admin`
* `carrierwave` + `cloudinary` — product images (Cloudinary in non-dev environments)
* `will_paginate` — pagination
* `good_job` — ActiveJob queue adapter (infrastructure only; no jobs defined yet)
* `redcarpet` — Markdown rendering for `_md`-suffixed i18n keys

* * *

#### Setup

```bash
bundle install
bin/rake db:create db:migrate
bin/rake db:seed        # if db/seeds.rb has data
bin/rails server         # http://localhost:3000
```

Database credentials are read from `STOREFRONT_DATABASE_HOST` / `STOREFRONT_DATABASE_USERNAME` /
`STOREFRONT_DATABASE_PASSWORD` (see `config/database.yml`); sensible local-dev defaults are used
if unset. `/admin` credentials come from `RAILS_ADMIN_USERNAME` / `RAILS_ADMIN_PASSWORD`
(defaults: `admin` / `changeme123` — override before any real deployment).

#### Tests

```bash
bundle exec rspec                              # full suite
bundle exec rspec spec/models/product_spec.rb  # one file
bundle exec rubocop                            # lint
```
