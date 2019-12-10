require 'services/download_service'

module AirportDeparture
  class CommonAirport
    KEYS = %i[code time destinations].freeze

    def download_departures
      raise(NotImplementedError)
    end
  end
end