require 'models/city'
require 'models/flight'
require 'models/flights_city'

module AirportDeparture
  class CommonWorker
    include Sidekiq::Worker

    def airport_klass
      @airport_klass ||= Object.const_get(@type.constantize).new
    end
  end
end