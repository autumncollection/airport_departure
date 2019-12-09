require_relative '../spec_helper'
require 'services/weather_service'

describe AirportDeparture::WeatherService do
  let(:klass) { described_class }

  before do
    stub_request(:get, /api/).to_return(
      status: 200,
      body: body)
  end

  describe '#download' do
    let(:body) { mock_file('services', 'weather_service_sample.json') }
    subject(:response) { klass.download(city) }

    context 'when data are ok' do
      let(:city) { 'Brno' }

      it 'temperature' do
        expect(response[:temperature]).to be(1.86)
      end

      it 'temperature' do
        expect(response[:clouds]).to be(82)
      end

      it 'temperature' do
        expect(response[:humidity]).to be(93)
      end
    end

    # context 'when data are not ok' do
    #   let(:body) do
    #     "<html>not a json</html>"
    #   end

    #   it 'returns Array' do
    #     expect { response }.to raise_error(AirportDeparture::WrongData)
    #   end
    # end
  end
end