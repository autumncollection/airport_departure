require 'nokogiri'

module AirportDeparture
  class HtmlParser
    class << self
      def parse(doc)
        Nokogiri::HTML(doc)
      end
    end
  end
end
