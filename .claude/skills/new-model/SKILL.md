---
name: new-model
description: Scaffold a new ActiveRecord model in this Rails app — model class, timestamped migration, minitest test file, and an empty fixture — following this project's existing conventions. Use when adding a brand-new model/table to the storefront app.
argument-hint: [ModelName] [field:type ...]
arguments: model_name fields
allowed-tools: Read, Write, Bash
---

Scaffold a new model called `$model_name` with fields `$fields` (space-separated
`name:type` pairs, e.g. `name:string price:integer`).

Before writing anything, read one existing example of each file below so the
new files match this project's actual style — don't invent a different
convention.

1. **Migration** — `db/migrate/<timestamp>_create_<table_name>.rb`.
   Timestamp format: `YYYYMMDDHHMMSS`, strictly greater than the last migration
   in `db/migrate/`. Follow the plain `create_table` + `t.<type> "<field>"`
   style already used there (see `db/schema.rb` for the exact column style —
   this app does NOT use `t.timestamps`, it lists `created_at`/`updated_at`
   explicitly with `null: false`). Add `t.references` + `add_foreign_key` only
   for fields the user names with a `_id` suffix or an explicit association.

2. **Model** — `app/models/<model_name_underscore>.rb`. Match the terse style
   in `app/models/product.rb` / `order_item.rb`: `belongs_to`/`has_many` first,
   then `validates`, no comments, no `attr_accessor`.

3. **Test** — `test/models/<model_name_underscore>_test.rb`. Match
   `test/models/product_test.rb`'s Minitest (not RSpec) style, subclassing
   `ActiveSupport::TestCase`.

4. **Fixture** — `test/fixtures/<table_name>.yml`. Add one named fixture row
   with plausible sample values for the given fields (look at an existing
   fixture file like `test/fixtures/products.yml` for the YAML shape).

After creating the files, print a short summary of what was created and
remind the user they still need to run `bin/rake db:migrate` themselves —
this skill only writes files, it never runs migrations against a real
database.
