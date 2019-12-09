if defined?(DATABASE)
  require 'sinatra/activerecord'
  ActiveRecord::Base.logger = LOGGER_INSTANCE
end
