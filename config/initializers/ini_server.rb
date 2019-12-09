# encoding:utf-8
require 'redis/connection/hiredis'
require 'redis'
require 'sidekiq'

# configure background logging

# configure redis - Sidekiq
redis_connection = proc do
  Redis.new(REDIS[:sidekiq][:connect].merge(driver: :hiredis))
end

Sidekiq.configure_server do |config|
  # configure redis
  config.redis = ConnectionPool.new(
    REDIS[:sidekiq][:connection_pool], &redis_connection)
end

Sidekiq.default_worker_options = {
  queue: :normal, retry: 6, failures: :exhausted }