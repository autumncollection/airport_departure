ENV['RACK_ENV'] = 'test'
require 'rspec'
require 'pry'
$LOAD_PATH << File.join(__dir__, '..', 'config')
require 'initializers/ini_config'
require 'initializers/ini_server'
require 'initializers/ini_client'
$LOAD_PATH << File.join(__dir__, '..', 'app')
require 'webmock/rspec'
#require 'initializers/ini_database'

def mock_file(*args)
  File.read(File.join(__dir__, 'mocks/', *args))
end
