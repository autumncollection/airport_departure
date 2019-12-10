require 'nokogiri'

module AirportDeparture
  class HtmlParser
    def create_nokogiri(doc)
      Nokogiri::HTML(doc)
    end

    def xpath(doc, key)
      doc.xpath(self.class::KEYS[key])
    end

    def at_xpath(doc, key)
      doc.at_xpath(self.class::KEYS[key])
    end
  end
end
