source 'https://rubygems.org'

ruby '3.2.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.1.5'
# Use SCSS for stylesheets
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'sassc-rails' # was sass-rails - its Sprockets-3-only lineage doesn't satisfy Rails 6's sprockets-rails

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

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

  # Access an IRB console on exception pages or by using <%= console %> in views
  # (was ~> 2.0, Rails-4-only - should also have been bumped back at
  # the Rails 5.0 stage; fixed now instead)
  gem 'web-console', '~> 4.2'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

gem 'haml', '~> 5.2' # haml-rails dropped: haml 5+ registers itself as an
                      # ActionView template handler, no separate gem needed

gem 'faker'
gem 'populator'

gem 'will_paginate'
gem 'will_paginate-bootstrap'

gem 'carrierwave'
gem 'cloudinary'

gem 'rails_admin', '~> 3.0' # 3.x targets Rails 6.1-7.x; verify config/initializers/rails_admin.rb against 3.x docs
gem "rails-erd"