# before run

`cp rp ./config/config.yml.example ./config/config.yml'
`cp rp ./config/database.yml.example ./config/database.yml'
`cp rp ./config/database.yml.example ./config/sidekiq.yml'
`cp rp ./config/database.yml.example ./config/sidekiq.yml'

`bundle exec rake db:create`
`bundle exec rake db:migrate`
`bundle exec rake airport_departure:avereage_temperature_service`

# to initial run
`bundle exec sidekiq -C ./sidekiq.yml`