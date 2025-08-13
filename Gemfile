# frozen_string_literal: true

source 'https://rubygems.org'

gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 8.0.2'
gem 'tzinfo-data', platforms: %i[windows jruby]

gem 'bootsnap', require: false
gem 'kamal', require: false
gem 'redis'
gem 'thruster', require: false

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rswag'
  gem 'rubocop-rails-omakase', require: false
  gem 'shoulda-matchers', '~> 5.0'
end
