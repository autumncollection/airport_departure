$LOAD_PATH.unshift(File.join(__dir__, 'config'))
$LOAD_PATH.unshift(File.join(__dir__, 'config', 'initializers'))

require 'ini_config'
require 'ini_database'

require 'sinatra/activerecord/rake'

namespace :db do
  task :load_config do
  end
end