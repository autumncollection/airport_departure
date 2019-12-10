require_relative 'html_parser'

module AirportDeparture
  class AvereageTemperatureParser < HtmlParser
    KEYS = {
      cities: '//div[@id="mw-content-text"]/div/table',
      city: './td[2]',
      temperatures: './td',
      temperature: './text()'
    }
    def perform(doc)
      parse(create_nokogiri(doc))
    end

  private

    def parse(doc)
      each_city(doc).map do |city|
        next unless city.xpath('./th').size.zero? # skip label

        parse_city(city)
      end.compact
    end

    def parse_city(city)
      name = at_xpath(city, :city)
      temperatures = xpath(city, :temperatures).each_with_index.each_with_object({}) do |(column, index), mem|
        next if index < 2 || index > 13
        mem[index - 1] = parse_temperature(column).to_f
      end
      { name: name.content.strip, temperatures: temperatures }
    end

    def parse_temperature(column)
      at_xpath(column, :temperature).content
    end

    def each_city(doc)
      s = xpath(doc, :cities).xpath('.//tr')
    end
  end
end