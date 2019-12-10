$LOAD_PATH.unshift(File.join(__dir__, 'config'))
$LOAD_PATH.unshift(File.join(__dir__, 'config', 'initializers'))

require 'ini_config'
require 'ini_database'

require 'sinatra/activerecord/rake'

require 'sidekiq'

namespace :sidekiq do
  task :reload_cron do
    require 'sidekiq-cron'
    Sidekiq::Cron::Job.destroy_all!
    schedule_file = File.join(__dir__, 'config/schedule.yml')
    Sidekiq::Cron::Job.load_from_hash(YAML.load_file(schedule_file))
  end
end

namespace :airport_departure do
  task :airport_scheduler => :setup do
    require 'workers/airport_scheduler'

    downloader = AirportDeparture::AirportScheduler.new
    downloader.perform(ENV['type'])
  end

  task :airport_downloader => :setup do
    require 'workers/airport_downloader'

    downloader = AirportDeparture::AirportDownloader.new
    downloader.perform(JSON.parse(ENV['data']))
  end

  task :avereage_temperature_service => :setup do
    require 'services/avereage_temperature_service'
    AirportDeparture::AvereageTemperatureService.perform
  end

  task :setup do
    $LOAD_PATH << File.join(__dir__, 'app')
  end
end
