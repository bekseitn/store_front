# frozen_string_literal: true

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Do not eager load code on boot. This avoids loading your whole application
  # just for the purpose of running a single test. If you are using a tool that
  # preloads Rails for running tests, you may have to set it to true.
  config.eager_load = false

  # Configure static file server for tests with Cache-Control for performance.
  # (both renamed from serve_static_files/static_cache_control in Rails 5)
  config.public_file_server.enabled = true
  config.public_file_server.headers = { 'Cache-Control' => 'public, max-age=3600' }

  # The app doesn't use Active Storage (CarrierWave + Cloudinary handle
  # uploads), but rails_admin 3.x's asset_source touches it regardless -
  # see config/storage.yml.
  config.active_storage.service = :test

  # Sprockets defaults config.assets.compile to false outside
  # development (production-like: only precompiled assets resolve).
  # Since nothing runs `assets:precompile` before the test suite, that
  # broke as soon as a page needed to resolve an asset through
  # Sprockets at request time (javascript_importmap_tags does, for its
  # module-preload links) - found by actually running the tests after
  # adding importmap-rails/turbo-rails.
  config.assets.compile = true
  config.assets.check_precompiled_asset = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Randomize the order test cases are executed.
  config.active_support.test_order = :random

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Per GUIDELINES.md: "tests use GoodJob Inline Adapter" - runs jobs
  # synchronously in the same process/thread as the request, matching
  # good_job's own README-documented default for the test environment.
  config.active_job.queue_adapter = :good_job
  config.good_job.execution_mode = :inline
end
