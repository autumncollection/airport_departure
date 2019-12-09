require 'nokogiri'

module AirportDeparture
  class NokogiriService
    class << self
      def perform(body, xpaths)
        doc = Nokogiri::HTML(body)
        yield(doc)
      end
    end
  end
end