require 'libs/json_helper'

module AirportDeparture
  class JsonParser
    def create_json(doc)
      JsonHelper.parse(doc)
    end
  end
end
