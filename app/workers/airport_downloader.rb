require_relative 'common_worker'
require 'services/weather_service'

module AirportDeparture
  class AirportDownloader < CommonWorker
    def perform(data)
      download(data)
    end

  private

    def download(data)
      weather = download_weather(data['destinations'])
      save_data(data, weather)
    end

    def save_data(data, weather)
      cities = save_city(weather)
      flights = save_flight(data)
      save_flights_cities(cities, flights)
    end

    def save_flights_cities(cities, flight)
      fc = cities.each_with_object([]) do |city, mem|
        mem << FlightsCity.where(flight_id: flight.id, city_id: city.id). \
          first_or_create(flight_id: flight.id, city_id: city.id).id
      end
      finded = FlightsCity.where(flight_id: flight.id, city_id: cities.map(&:id)).map(&:id)
      (finded - fc).each { |id| FlightsCity.delete(id: id) }
      fc
    end

    def save_flight(code)
      flight = Flight.where(code: code['code']).first_or_create(
        code: code['code'])
      flight.update_attributes(time: code['time'])
      flight
    end

    def save_city(destinations)
      destinations.map do |destination, values|
        city = City.where(name: destination).first_or_create(
          name: destination)
        city.update_attributes(temperature: values[:temperature])
        city
      end
    end

    def download_weather(cities)
      cities.each_with_object({}) do |city, mem|
        mem[city['city']] = WeatherService.download(city['city'])
      end
    end

    def create_job(airport)
      method = ENV['RACK_ENV'] == 'test' ? :perform : :perform_async
      AirportDownloader.send(method, airport)
    end
  end
end