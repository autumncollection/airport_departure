require 'unicode_utils/downcase'

require 'services/download_service'
require 'parsers/avereage_temperature_parser'
require 'models/city_temperature'
require 'models/city'

module AirportDeparture
  class AvereageTemperatureService
    URL = 'https://en.wikipedia.org/wiki/List_of_cities_by_average_temperature'

    class << self
      def perform
        response = DownloadService.download(
          url: URL, params: { cache: CACHE[:cache] })
        save_data(prepare_data(response.response_body))
      end

    private

      def prepare_data(doc)
        AvereageTemperatureParser.new.perform(doc)
      end

      def save_data(data)
        puts "#{data.size}"
        CityTemperature.connection.truncate(CityTemperature.table_name)
        counter = 0
        data.each do |city_item|
          counter += 1
          puts counter.to_s
          downcased = UnicodeUtils.downcase(city_item[:name])
          city = City.where(name: downcased).first_or_create(
            name: downcased)

          city_item[:temperatures].each do |month, temperature|
            CityTemperature.create(
              city_id: city.id,
              month: month,
              temperature: temperature)
          end
        end
        data.size
      end

      def create_url(city)
        URL % [city, OPENWEATHER[:key]]
      end
    end
  end
end