require 'services/download_service'
require 'services/json_service'

module AirportDeparture
  class CommonAirport
    def download_departures
      raise(NotImplementedError)
    end
  end
end