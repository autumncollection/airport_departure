require 'models/city_temperature'

module AirportDeparture
  class NoteResolver
    ZONES = {
      'freezing' => [-10, -80],
      'cold' => [-10, 0],
      'avereage' => [0, 10],
      'not bad' => [10, 20],
      'just ok' => [20, 30],
      'hot' => [30, 40],
      'warm' => [40, 100] }.freeze
    CITIES = {
      'london' => { ['not bad', 'just ok', 'hot', 'warm'] => 'Beer is waiting' },
      'prague' => { ['not bad', 'just ok', 'hot', 'warm'] => 'Pivo!' },
      'madrid' => { ['just ok', 'hot', 'warm'] => 'Swimsuit up!' },
      'sydney' => { ['just ok', 'hot', 'warm'] => 'Swimsuit up!', ['freezing', 'cold', 'avereage'] => 'Some opera' }
    }

    class << self
      def resolve(cities, data)
        cities.each_with_index.map do |city, index|
          avereage = CityTemperature.where(
            city_id: city.id,
            month: Time.parse(data['time']).strftime('%m').to_i).first

          text = resolve_city(index + 1, city, avereage)
          tail_text = tail_text(city)

          text = index.zero? ? text.camelize : text
          "#{text}#{tail_text}"
        end.join(' and on the next stop ')
      end

    private

      def tail_text(city)
        return '' unless CITIES.include?(city.name)

        zone = resolve_zone(city)
        return '' unless zone

        CITIES[city.name].each do |keys, text|
          return " #{text}" if keys.include?(zone)
        end

        ''
      end

      def resolve_city(index, city_temp, avg_temp)
        return "we don't know nothing about forecast on the #{index} stop" if \
          city_temp.blank? || city_temp.temperature.nil? || avg_temp.blank? ||
          avg_temp.temperature.blank?

        zone = resolve_zone(city_temp)
        avereage = city_temp.temperature < avg_temp.temperature ? :lower : :higher
        "the temperature is #{zone}, but #{avereage} than usual in this part of the year"
      end

      def resolve_zone(city_temp)
        ZONES.each do |key, temp|
          return key if city_temp.temperature.between?(*temp)
        end
        "we don't know"
      end
    end
  end
end