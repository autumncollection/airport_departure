require_relative '../spec_helper'
require 'workers/airport_downloader'

describe AirportDeparture::AirportDownloader do
  let(:klass) { described_class.new }

  before do
    allow(klass).to receive(:airport_departures).and_return(data)
    allow(klass).to receive(:download_weather).and_return(weather_data)
  end

  describe '#download' do
    let(:data) do
      {
        "code" => "OS 359",
        "time" => "2019-12-09T12:40:00.000",
        "destinations" => ['Brussels', 'Sydney'] }
    end

    let(:weather_data) do
      { 'brussels' => { temperature: 20 },
        'sydney' => { temperature: 25 } }
    end

    subject { klass.perform(data) }

    context 'when data are ok' do
      it { is_expected.to be_truthy }
    end
  end
end