require_relative 'common_airport'
require 'parsers/vienna_airport_parser'

module AirportDeparture
  class ViennaAirport < CommonAirport
    URL = 'https://www.viennaairport.com/jart/prj3/va/data/flights/out.json'.freeze

    def download_departures
      data = DownloadService.download(url: URL).response_body
      parse_departures(data)
    end

  private

    def parse_departures(data)
      ViennaAirportParser.new.perform(data)
    end
  end
end
