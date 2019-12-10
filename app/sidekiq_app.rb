$LOAD_PATH << File.join(__dir__, '../config')
$LOAD_PATH << File.join(__dir__)

require 'sidekiq'
require 'sidekiq/api'

require 'initializers/ini_config'
require 'initializers/ini_server'
require 'initializers/ini_database'
require 'initializers/ini_workers'
