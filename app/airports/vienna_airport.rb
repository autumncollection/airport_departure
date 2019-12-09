require_relative 'common_airport'

module AirportDeparture
  class WrongData < StandardError; end
  class ViennaAirport < CommonAirport
    URL = 'https://www.viennaairport.com/jart/prj3/va/data/flights/out.json'.freeze
    KEYS = {
      code: %w{fn},
      time: %w{schedule},
      destinations: { 'destinations' => { 'city' => %w{nameEN} } }
    }

    def download_departures
      json_data = JsonService.parse(DownloadService.download(url: URL).response_body)
      raise(WrongData, json_data[:data]) unless json_data[:status] == :ok

      json_data[:data].dig('monitor', 'departure').map do |departure|
        JsonService.parse_keys(departure, KEYS)
      end
    end
  end
end
