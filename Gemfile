source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# https://github.com/zquestz/omniauth-google-oauth2
gem "omniauth-google-oauth2"
# https://github.com/zquestz/omniauth-google-oauth2
gem "omniauth-rails_csrf_protection"

# https://github.com/rails/tailwindcss-rails
gem "tailwindcss-rails"

# https://ddnexus.github.io/pagy/quick-start/#1-install
gem "pagy", "~> 9.3"

gem "slim-rails"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  # https://github.com/rubocop/rubocop-rspec?tab=readme-ov-file#installation
  gem "rubocop-rspec", require: false

  # https://github.com/rubocop/rubocop-capybara?tab=readme-ov-file#installation
  gem "rubocop-capybara", require: false

  # https://github.com/sds/slim-lint
  gem "slim_lint", require: false

  # https://github.com/rspec/rspec-rails?tab=readme-ov-file#installation
  gem "rspec-rails", "~> 8.0.2"

  # https://github.com/thoughtbot/factory_bot_rails?tab=readme-ov-file
  gem "factory_bot_rails"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # https://github.com/teamcapybara/capybara?tab=readme-ov-file#setupq
  gem "capybara"
  # https://github.com/SeleniumHQ/selenium/tree/trunk/rb
  gem "selenium-webdriver"

  # https://github.com/simplecov-ruby/simplecov
  gem "simplecov", require: false
end
