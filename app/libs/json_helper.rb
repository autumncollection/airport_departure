require 'multi_json'
require 'hashie'

module AirportDeparture
  class JsonHelper
    class << self
      def parse(json)
        MultiJson.load(json)
      end

      def dump(json)
        MultiJson.dump(json)
      end
    end
  end
end