# AGENTS.md

## Project

Storefront is a Ruby on Rails 8 application using PostgreSQL, Bootstrap 5,
Hotwire, Haml, and RSpec. RailsAdmin is mounted at `/admin`.

## Working conventions

- Read and follow [GUIDELINES.md](GUIDELINES.md) before making application
  changes; it is the source of truth for implementation conventions.
- Use the repository's `storefront-rails` skill in
  `.codex/skills/storefront-rails` for Rails feature work and reviews.
- Keep customer-facing text in `config/locales/en.yml` and use relative I18n
  keys in views where practical. RailsAdmin uses its own built-in locale.
- Use `FrontdoorForm` for application forms. Its `group`, `label`, `input`, and
  `errors` helpers add Bootstrap form classes, so do not add those classes at
  call sites.
- Use RSpec and FactoryBot for tests. Prefer behavioral request specs and real
  objects over mocks.
- Do not change dependencies, Rails configuration, initializers, or RSpec
  support files unless the requested task explicitly requires it.

## Commands

```bash
bin/rails server
bin/rails console
bin/rails db:migrate
bin/rails db:seed
bundle exec rspec
bundle exec rspec spec/models/product_spec.rb
```

Enable the repository hook once per clone with
`git config core.hooksPath .githooks`; it validates syntax for staged Ruby
files before commits.

## Domain notes

- `Order` is the shopping cart; `current_order` uses `session[:order_id]`.
- `OrderItem` belongs to the current order until checkout and snapshots product
  prices when persisted.
- Checkout creates an `Ordering` and reassigns its order items from the cart.
- `Product` uses `default_scope { where(active: true) }`; inactive products are
  hidden unless explicitly unscoped.
