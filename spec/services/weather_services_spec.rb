require_relative '../spec_helper'
require 'services/weather_service'

describe AirportDeparture::WeatherService do
  let(:klass) { described_class }

  before do
    stub_request(:get, /api/).to_return(
      status: status,
      body: body)
  end

  describe '#download' do
    subject(:response) { klass.download(city) }

    let(:body) { mock_file('services', 'weather_service_sample.json') }
    let(:status) { 200 }

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

    context 'when data are not ok' do
      WebMock.allow_net_connect!
      let(:city) { 'City which doesnt exists' }
      let(:status) { 404 }
      let(:body) do
        "{\"cod\":\"404\",\"message\":\"city not found\"}"
      end

      it 'returns Array' do
        expect(response).to eq({})
      end
    end
  end
end