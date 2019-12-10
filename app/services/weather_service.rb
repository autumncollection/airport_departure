require 'services/download_service'
require 'parsers/weather_parser'

module AirportDeparture
  class WeatherService
    URL = 'http://api.openweathermap.org/data/2.5/weather?q=%s&APPID=%s'

    class << self
      def download(city)
        raise(StandardError, "Missing API key for Openweathermap") unless \
          OPENWEATHER[:key].present?

        response = DownloadService.download(
          url: create_url(city), params: { cache: CACHE[:cache] })
        prepare_data(response.response_body)
      rescue AirportDeparture::HttpError
        {}
      end

    private

      def prepare_data(json)
        WeatherParser.new.perform(json)
      end

      def create_url(city)
        URL % [city, OPENWEATHER[:key]]
      end
    end
  end
end
