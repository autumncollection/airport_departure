require 'multi_json'
require 'hashie'

module AirportDeparture
  class JsonService
    class << self
      def parse(json)
        { status: :ok, data: MultiJson.load(json) }
      rescue MultiJson::ParseError => e
        { status: :error, errors: [e.message]}
      end

      def parse_keys(data, json_keys)
        json_keys.each_with_object({}) do |(return_key, keys), mem|
          mem[return_key] = \
            if keys.is_a?(Array)
              data.dig(*keys)
            else
              data.dig(keys.keys[0]).map do |departure_item|
                parse_keys(departure_item, keys[keys.keys[0]])
              end
            end
        end
      end
    end
  end
end