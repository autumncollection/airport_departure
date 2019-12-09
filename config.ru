#!/usr/bin/env ruby
require 'sinatra'
Encoding.default_external = Encoding::UTF_8
$LOAD_PATH.unshift(File.join(__dir__, 'app'))
$LOAD_PATH.unshift(File.join(__dir__, 'config'))

require 'sidekiq'

require 'initializers/ini_config'
require 'initializers/ini_client'

require 'sidekiq/web'
require 'sidekiq-cron'
require 'sidekiq/cron/web'

run Rack::URLMap.new('/' => Sidekiq::Web.new)
