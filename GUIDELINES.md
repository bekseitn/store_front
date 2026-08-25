# Project Guidelines

## Project Overview
This is a Ruby on Rails application that helps users with benefits applications. The application uses:
- Ruby on Rails 8
- PostgreSQL database
- Bootstrap 5.3 for UI styling
- Hotwire (Turbo and Stimulus) for frontend interactivity
- RSpec for testing

## Project Structure
The project follows standard Rails conventions:
- `app/` - Contains the core application code (MVC)
- `bin/` - Contains executable scripts
- `config/` - Contains configuration files
- `db/` - Contains database schema and migrations
- `lib/` - Contains library code
- `public/` - Contains public assets
- `spec/` - Contains tests
- `scripts/` - Contains utility scripts

## Development Workflow

### Running the Application
- Use `bin/rails server` to start the development server
- Use `bin/rails console` to start the Rails console

### Database Operations
- Use `bin/rails db:migrate` to run pending migrations
- Use `bin/rails db:seed` to seed the database
- Use `bin/rails db:reset` to reset the database

### Running Tests
- Use `bin/rspec` to run all tests
- Use `bin/rspec [path]` for specific tests

## Coding Guidelines

### General
- Write concise, idiomatic Ruby code with accurate examples
- Follow Rails conventions and best practices
- Use object-oriented and functional programming patterns as appropriate
- Prefer iteration and modularization over code duplication
- Use descriptive variable and method names (e.g., user_signed_in?, calculate_total)
- Structure files according to Rails conventions (MVC, concerns, helpers, etc.)
- NEVER modify the Gemfile, Rails configuration or initializers, nor RSpec configuration or test support files. All instructions are intended to be implemented within the existing application configuration and dependencies. If something appears to be missing or misconfigured, stop.

### Common Patterns
- If a form url or controller redirect is to an action in the same controller, use a hash with the action name as the key e.g. `{ action: :new }`
- When making migrations, use `text` for all string fields; never use `string` or `varchar`

### Naming Conventions
- Use snake_case for file names, method names, and variables
- Use CamelCase for class and module names
- Follow Rails naming conventions for models, controllers, and views

### Ruby and Rails Usage
- Use Ruby 3.x features when appropriate (e.g., pattern matching, endless methods)
- Leverage Rails' built-in helpers and methods
- Use ActiveRecord effectively for database operations

### Syntax and Formatting
- Follow the Ruby Style Guide (https://rubystyle.guide/)
- Use Ruby's expressive syntax (e.g., unless, ||=, &.)
- Prefer double quotes for strings
- Always strip whitespace at the end of lines and ensure a blank line exists at the end of the file

### Controllers
- When adding new controllers or actions, don't forget to update the routes.rb
- Use `expect` syntax instead of `require`/`allow` for strong parameters:
  ```ruby
  # Good
  params.expect(user: [:name, :favorite_pie])

  # Bad
  params.require(:user).permit(:name, :favorite_pie)
  ```
- Unless parameters are reused more than once, assign strong parameters to a local variable rather than a method
- When linking or redirecting to an action in the same controller, use `url_for(action: "the_action")` instead of path helpers

### View templates
- Use the custom form builder `FrontdoorForm` which contains helpers for structure bootstrap forms.
- When using `FrontdoorForm`, do not add Bootstrap classes like `form-label`/`form-control`/`form-select`; they're already added by the FrontdoorForm builder.
- Most simple form inputs will have this structure of `group`, `label`, `input`, and `errors`:
  ```
  <%= f.group(:first_name, class: "col-3") do %>
    <%= f.label :first_name, "First Name" %>
    <%= f.input :first_name %>
    <%= f.errors :first_name %>
  <% end %>
  ```
- When creating `select` tags, use `include_blank: "string"` instead of manually adding a blank option to the list of options.

### Internationalization
- All public or client-facing pages will be translated. Admin pages will not be translated.
- Follow Rails I18n conventions for extracting strings to config/locales.
- Use relative identifiers whenever possible. For example, the relative `t(".title")` in `app/views/pages/homepage` is preferred to `t("pages.homepage.title")`.
- For simple strings that contain HTML, name the key with `_md` suffix and author the strings in Markdown instead of HTML.
  - The Markdown will be automatically rendered to HTML and marked as HTML safe.
  - Multiline strings should break paragraphs with 2 newlines. Single-line strings will not be wrapped with p tags.
  - Do not use the `_md` suffix when strings do not contain HTML formatting.
  - This custom functionality is implemented in `config/initializers/markdown.rb`.

### Database Migrations
- Always create a migration using `bin/rails g migration <NAME>`. If a migration has been created in the current development feature branch, rollback the migration, edit it and then roll forward rather than creating a new migration.
- Use `text` for all string fields; never use `string` or `varchar`
- Use `datetime` instead of `timestamp`
- Assume that Boolean values should be nullable unless specified

### Testing
- Write tests using RSpec. It's ok to put multiple assertions in the same example
- Use factories (FactoryBot) for test data generation
- Prefer real objects over mocks unless there is an external dependency like a third party API call. Use `instance_double` if necessary; never `double`
- Don't test declarative configuration. For validations, only test that it's not valid when the validation is violated. `shoulda-matchers` is not used.
- Test controllers behaviorally: assert on status code and/or data changes
- Use Timecop for time traveling
- By default tests use GoodJob Inline Adapter. To use the Active Job test adapter use the `:active_job` option for the test

#### System Tests
- When writing System Tests, use `css_id(*)` and `css_class(*)` instead of `"#{dom_id(*)}"` `"#{dom_class(*)}"`
- Use Capybara async matchers and expectations and generally avoid asserting on `find` methods that may be flaky.

## Performance Optimization
- Use database indexing effectively
- Implement caching strategies (fragment caching, Russian Doll caching)
- Use eager loading to avoid N+1 queries
- Optimize database queries using includes, joins, or select
