# before run

`cp rp ./config/config.yml.example ./config/config.yml'

`cp rp ./config/database.yml.example ./config/database.yml'

`cp rp ./config/sidekiq.yml.example ./config/sidekiq.yml'

`cp rp ./config/scheduler.yml.example ./config/scheduler.yml'


`bundle exec rake db:create`

`bundle exec rake db:migrate`

`bundle exec rake airport_departure:avereage_temperature_service`

`bundle exec rake sidekiq:reload_cron`

# to initial run
`bundle exec sidekiq -C ./sidekiq.yml`
