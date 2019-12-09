require 'workers/airport_downloader'
require_relative 'common_worker'

module AirportDeparture
  class AirportScheduler < CommonWorker
    include Sidekiq::Worker

    def perform(type)
      @type = type
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
      AirportDownloader.perform_async(airport)
    end
  end
end