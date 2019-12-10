require 'sidekiq/api'
require 'active_support/core_ext/string/inflections'

require 'models/city'
require 'models/flight'
require 'models/flights_city'
require 'models/city_temperature'

module AirportDeparture
  class CommonWorker
    include Sidekiq::Worker
    sidekiq_options queue: 'default'

    def airport_klass
      require "airports/#{@type}"
      @airport_klass ||= Object.const_get("AirportDeparture::#{@type.classify}").new
    end
  end
end
