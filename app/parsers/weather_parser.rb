require_relative 'json_parser'

module AirportDeparture
  class WeatherParser < JsonParser
    TEMPERATURE_CONSTANT = 273.15
    KEYS = {
      temperature: %w[main temp],
      clouds: %w[clouds all],
      humidity: %w[main humidity] }.freeze

    def perform(doc)
      parse(create_json(doc))
    end

  private

    def parse(doc)
      data = KEYS.each_with_object({}) do |(key, digs), mem|
        mem[key] = doc.dig(*digs)
      end
      data[:temperature] = (data[:temperature] - TEMPERATURE_CONSTANT).round(2)
      data
    end
  end
end
