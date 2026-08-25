---
name: storefront-rails
description: "Implement or review features in the Storefront Rails application. Use for models, checkout/cart behavior, Haml views, I18n, migrations, and RSpec tests in this repository."
---

# Storefront Rails

Read `AGENTS.md` and `GUIDELINES.md` before changing application code.

## Application conventions

- Keep customer-facing strings in `config/locales/en.yml`. Prefer relative
  translation keys in views. Keys ending in `_md` are rendered as Markdown.
- Use `FrontdoorForm` for application forms. Its `group`, `label`, `input`, and
  `errors` helpers add the Bootstrap form classes.
- Write RSpec tests with FactoryBot. Use request specs for controller behavior
  and avoid mocks unless an external dependency makes one necessary.
- Follow the migration requirements in `GUIDELINES.md`, including using `text`
  for string-like columns and `datetime` for timestamps.

## Domain invariants

- An `Order` is the current shopping cart, resolved through `session[:order_id]`.
- `OrderItem` prices are snapshotted after persistence; do not assume later
  product price changes affect existing items.
- Checkout creates an `Ordering` and moves the cart's items to it. Preserve
  this handoff when changing checkout code.
- Products are hidden by default when `active` is false.

## Verification

Run the most focused relevant spec first, then `bundle exec rspec` when the
database is available. The repository's `pre-commit` hook checks Ruby syntax
for staged Ruby files.
