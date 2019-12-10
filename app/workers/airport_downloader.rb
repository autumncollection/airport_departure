require_relative 'common_worker'
require 'services/weather_service'
require 'libs/note_resolver'
require 'unicode_utils/downcase'

module AirportDeparture
  class AirportDownloader < CommonWorker
    def perform(data)
      raise_missing_avereage?

      download(data)
    end

  private

    def raise_missing_avereage?
      raise(
        StandardError,
        'Missing avereage temperature data, run ' \
        'rake airport_departure:avereage_temperature_service') if \
        CityTemperature.count.zero?
    end

    def download(data)
      weather = download_weather(data['destinations'])
      save_data(data, weather)
    end

    def save_data(data, weather)
      cities = save_city(weather)
      flights = save_flight(data, cities)
      save_flights_cities(cities, flights)
      true
    end

    def save_flights_cities(cities, flight)
      flight_cities = cities.each_with_object([]) do |city, mem|
        mem << FlightsCity.where(flight_id: flight.id, city_id: city.id). \
          first_or_create(flight_id: flight.id, city_id: city.id).id
      end
      finded = FlightsCity.where(flight_id: flight.id, city_id: cities.map(&:id)).map(&:id)
      (finded - flight_cities).each { |id| FlightsCity.delete(id: id) }
      flight_cities
    end

    def save_flight(data, cities)
      note = NoteResolver.resolve(cities, data)
      flight = Flight.where(code: data['code']).first_or_create(
        code: data['code'])
      flight.update(time: data['time'], note: note)
      flight
    end

    def save_city(destinations)
      destinations.map do |destination, values|
        downcased = UnicodeUtils.downcase(destination)
        city = City.where(name: downcased).first_or_create(
          name: downcased)
        city.update(temperature: values[:temperature])
        city
      end
    end

    def download_weather(cities)
      cities.each_with_object({}) do |city, mem|
        mem[UnicodeUtils.downcase(city['city'])] = weather_service_download(city)
      end
    end

    def weather_service_download(city)
      WeatherService.download(city['city'])
    rescue AirportDeparture::HttpError
      nil
    end

    def create_job(airport)
      method = ENV['RACK_ENV'] == 'test' ? :perform : :perform_async
      AirportDownloader.send(method, airport)
    end
  end
end