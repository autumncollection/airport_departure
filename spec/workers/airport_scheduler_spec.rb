require_relative '../spec_helper'
require 'workers/airport_scheduler'

describe AirportDeparture::AirportScheduler do
  let(:klass) { described_class.new }

  before do
    allow(klass).to receive(:airport_departures).and_return(data)
  end

  describe '#download' do
    let(:data) do
      [{ code: "OS 229", time: "2019-12-09T12:40:00.000", destinations: [{ "city"=>"Berlin TXL" }] },
       { code: "OS 359", time: "2019-12-09T12:40:00.000", destinations: [{ "city"=>"Brussels" }] }]
    end
    subject { klass.perform('vienna_airport') }

    context 'when data are ok' do
      it 'has 2 jids' do
        expect(subject.size).to be(2)
      end
    end
  end
end