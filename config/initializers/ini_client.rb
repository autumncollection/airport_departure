# initialize Puma/Thin/Passenger whatever server
require 'redis/connection/hiredis'
require 'redis'
require 'connection_pool'

# configure redis - Sidekiq
redis_connection = proc do
  Redis.new(REDIS[:sidekiq][:connect].merge(driver: :hiredis))
end

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(
    REDIS[:sidekiq][:connection_pool].merge(size: 1), &redis_connection)
end
