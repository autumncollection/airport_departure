require_relative '../spec_helper'
require 'parsers/vienna_airport_parser'

describe AirportDeparture::ViennaAirportParser do
  describe '#perform' do
    let(:file) { mock_file('airports', 'vienna_airport_sample.json') }
    subject(:response) { described_class.new.perform(file) }

    context 'when data are ok' do
      it 'is Array' do
        expect(response).to be_a(Array)
      end

      it 'is Array' do
        expect(response).not_to be_empty
      end
    end
  end
end
