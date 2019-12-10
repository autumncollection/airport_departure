require 'workers/airport_downloader'
require_relative 'common_worker'

require 'active_support/core_ext/hash/keys'

module AirportDeparture
  class AirportScheduler < CommonWorker
    include Sidekiq::Worker

    def perform(type, force = false)
      @type = type
      @force = force
      download_departures
    end

  private

    def download_departures
      airport_departures.map do |airport|
        create_job(airport)
      end
    end

    def airport_departures
      airport_klass.download_departures
    end

    def create_job(airport)
      if @force
        AirportDownloader.new.perform(airport.stringify_keys)
      else
        AirportDownloader.perform_async(airport)
      end
    end
  end
end
