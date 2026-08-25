# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

Generic online store built with Ruby on Rails 8 / Ruby 3.4 / PostgreSQL. Views use Haml, Bootstrap 5, Hotwire, and Stimulus. The admin panel is mounted via `rails_admin` at `/admin`.

## Commands

```bash
bundle install                  # install gems
bin/rails server                # run app locally (http://localhost:3000)
bin/rails console               # Rails console

bin/rake db:create db:migrate   # set up the database
bin/rake db:seed                # seed data (see db/seeds.rb if present)
RAILS_ENV=test bin/rake db:migrate  # migrate test DB (uses fixtures, not factories)

bin/rake test                          # run full test suite (Minitest)
bin/rake test test/models/product_test.rb          # run one file
bin/rake test test/models/product_test.rb -n test_the_truth  # run one test by name
```

There is no configured linter/rubocop in this repo.

## Architecture

The app models a small e-commerce checkout flow spread across a handful of resources; the relationships matter more than any single file:

- **Order = the cart.** There is no separate `Cart` model. `ApplicationController#current_order` (`app/controllers/application_controller.rb`) resolves the "current cart" from `session[:order_id]`, creating a new unsaved `Order` when none exists yet. `CartsController#show` just renders `current_order.order_items`.
- **OrderItem is created/updated/destroyed against `current_order`**, not through nested routes — `OrderItemsController` loads `@order = current_order` in a `before_filter` and creates items via `@order.order_items.new(...)`. The order is only persisted (and `session[:order_id]` set) on the first item added.
- **Pricing is snapshotted on the order item.** `OrderItem#unit_price` reads from `product.price` until the record is persisted, then a `before_save :finalize` callback freezes `unit_price`/`total_price` onto the row — so price changes on `Product` afterwards don't retroactively change past orders. `Order#total` is likewise recomputed from its `order_items` in a `before_save` callback.
- **Checkout ("ordering") is a separate step, and the cart empties itself via a side effect, not by clearing the session.** `Ordering` (delivery address/city/phone + `order_status`) is created via `OrderingsController#create`. Its `after_create :set_order_items` does `order.order_items.update_all(ordering_id: id, order_id: nil)` — it mass-reassigns the order's items onto the new `Ordering` (which has its own denormalized `total`, snapshotted in `before_create`). `session[:order_id]` is never deleted; the same `Order` row is what `current_order` keeps resolving to, it just has zero `order_items` left, so it reads as an empty cart again. One consequence: that `Order` row is not immutable after checkout — if items get added under the same `session[:order_id]` afterwards, `Order#total` (recomputed via `before_save`) changes on what is, via `Ordering#order_id`, still referenced as "the completed order."
- **Products** use `default_scope { where(active: true) }` (soft delete/visibility via the `active` flag — inactive products are invisible everywhere unless explicitly unscoped) and are filterable/searchable via the `filterrific` gem (`with_price_gte`, `with_price_lt`, `search_query` scopes on `Product`). `ProductsController#index` responds to both `format.html` and `format.js` (AJAX-driven filtering/pagination with `will_paginate`).
- Product images are handled by `carrierwave` (`app/uploaders/picture_uploader.rb`) with Cloudinary as the storage backend in non-dev environments.
- `db/schema.rb` is the source of truth for the DB shape; foreign keys are enforced at the DB level (`add_foreign_key`).
- Tests are Minitest with fixtures (`test/fixtures/*.yml`), not FactoryBot/RSpec — one fixture set is shared across all test files (`fixtures :all` in `test/test_helper.rb`).
