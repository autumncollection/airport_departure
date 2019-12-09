require_relative '../spec_helper'
require 'webmock/rspec'
require 'airports/vienna_airport'

describe AirportDeparture::ViennaAirport do
  let(:klass) { described_class.new }

  before do
    stub_request(:get, described_class::URL).to_return(
      status: 200,
      body: body)
  end

  describe '#download_departures' do
    subject(:response) { klass.download_departures }

    context 'when data are ok' do
      let(:body) do
        mock_file(%w[airports vienna_airport_sample.json])
      end

      it 'returns Array' do
        binding.pry
        expect(response).to be_a(Array)
      end

      it 'returns some data' do
        described_class::KEYS.keys.each do |key|
          expect(response[0][key]).not_to be_empty
        end
      end
    end

    context 'when data are not ok' do
      let(:body) do
        "<html>not a json</html>"
      end

      it 'returns Array' do
        expect { response }.to raise_error(AirportDeparture::WrongData)
      end
    end
  end
end