require_relative '../spec_helper'
require 'parsers/avereage_temperature_parser'

describe AirportDeparture::AvereageTemperatureParser do
  let(:file) { mock_file('parsers', 'wiki_cities.html') }

  describe '#download' do
    subject(:response) { described_class.new.perform(file) }

    context 'when data are ok' do
      it 'temperature' do
        expect(response).to be_a(Array)
      end
    end
  end
end
