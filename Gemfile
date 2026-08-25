# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.4.9'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 8.0.0'
# Use SCSS for stylesheets
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'sassc-rails' # was sass-rails - its Sprockets-3-only lineage doesn't satisfy Rails 6's sprockets-rails

# jquery-rails dropped: Turbo/Stimulus (see below) replaced the last
# things that needed it (remote:true forms, rails-ujs delete links) -
# confirmed via grep that no view/JS file references jQuery/$( ) or
# rails-ujs data attributes anymore before removing the gem.
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Hotwire: replaces turbolinks (classic) + rails-ujs. turbo-rails'
# asset-pipeline (Sprockets) install path requires importmap-rails to
# be present and listed first, even though we're not otherwise moving
# off Sprockets yet - found by actually checking turbo-rails' README
# before guessing at a manual Sprockets-only setup.
gem 'importmap-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Rails no longer bundles a default app server - found by actually
# trying to run `bin/rails server` ("Could not find a server gem").
gem 'puma'

# Postgres driver - needed in every environment, database.yml uses the
# postgresql adapter for development/test too, not just production/staging.
gem 'pg'

# rails_12factor removed here (should have happened back at the Rails
# 5.0 stage - it was folded into Rails core then; noticed late, fixed
# now instead of leaving it as dead weight).

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Per GUIDELINES.md: RSpec + FactoryBot, replacing Minitest + fixtures
  # entirely (see Stage D commit for the full test/ -> spec/ conversion).
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

# spring (dev boot-time speedup) dropped: it conflicts with Rails 7.2's
# test-environment reloading assumptions (`config.enable_reloading`),
# found by actually trying to run the test suite - not worth fighting
# for an app this small, Zeitwerk boot is already fast.

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views.
  # Found by actually running the app: it was in :development, :test
  # (was ~> 2.0, Rails-4-only - should also have been bumped back at
  # the Rails 5.0 stage), and web-console itself warns loudly if
  # loaded in test - moved to :development only, as it warns to do.
  gem 'web-console', '~> 4.2'
end

gem 'haml', '~> 5.2' # haml-rails dropped: haml 5+ registers itself as an
# ActionView template handler, no separate gem needed

gem 'faker'

gem 'will_paginate'
gem 'will_paginate-bootstrap'

gem 'carrierwave'
gem 'cloudinary'

gem 'rails_admin', '~> 3.0' # 3.x targets Rails 6.1-7.x; verify config/initializers/rails_admin.rb against 3.x docs
gem 'rails-erd'

gem 'rubocop', require: false
gem 'rubocop-performance', require: false
gem 'rubocop-rails', require: false
gem 'rubocop-rspec', require: false
