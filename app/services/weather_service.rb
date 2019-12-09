require 'services/download_service'
require 'services/json_service'

module AirportDeparture
  class WeatherService
    TEMPERATURE_CONSTANT = 273.15
    URL = 'http://api.openweathermap.org/data/2.5/weather?q=%s&APPID=%s'
    KEYS = {
      temperature: %w[main temp],
      clouds: %w[clouds all],
      humidity: %w[main humidity] }.freeze

    class << self
      def download(city)
        response = DownloadService.download(url: create_url(city))
        prepare_data(JsonService.parse(response.response_body))
      end

    private

      def prepare_data(json)
        data = JsonService.parse_keys(json[:data], KEYS)
        data[:temperature] = (data[:temperature] - TEMPERATURE_CONSTANT).round(2)
        data
      end

      def create_url(city)
        URL % [city, OPENWEATHER[:key]]
      end
    end
  end
end