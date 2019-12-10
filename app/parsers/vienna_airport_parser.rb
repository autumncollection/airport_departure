require_relative 'json_parser'

module AirportDeparture
  class WrongData < StandardError; end
  class ViennaAirportParser < JsonParser
    KEYS = %i[code time destinations].freeze

    def perform(data)
      parse_departures(JsonHelper.parse(data))
    rescue MultiJson::ParseError
      raise(WrongData, data.to_s)
    end

  private

    def parse_departures(data)
      (data.dig('monitor', 'departure') || []).map do |departure|
        KEYS.each_with_object({}) do |key, mem|
          mem[key] = send("parse_departure_#{key}", departure)
        end
      end
    end

    def parse_departure_time(data)
      data['schedule']
    end

    def parse_departure_code(data)
      data['fn']
    end

    def parse_departure_destinations(data)
      data['destinations'].map { |destination| destination.dig('city', 'nameEN') }
    end
  end
end
