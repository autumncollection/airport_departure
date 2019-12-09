source 'https://rubygems.org'

gem 'activesupport'
gem 'connection_pool'
gem 'hiredis'
gem 'redis'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sinatra'
gem 'unicode_utils'

# web parsing
gem 'hashie'
gem 'multi_json'
gem 'nokogiri'
gem 'rake'
gem 'typhoeus', require: ['typhoeus', 'typhoeus/adapters/faraday']

# mysql
gem 'activerecord'
gem 'sinatra-activerecord'
gem 'sqlite3', '~> 1.3'

# devel party
group :development do
  gem 'rubocop'
  gem 'shotgun'
  gem 'thin'
end

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'webmock'
end
