# Before

`cp rp ./config/config.yml.example ./config/config.yml`

`cp rp ./config/database.yml.example ./config/database.yml`



`bundle exec rake db:create`

`bundle exec rake db:migrate`

`bundle exec rake airport_departure:avereage_temperature_service`

`bundle exec rake sidekiq:reload_cron`

# For run

## Run sidekiq

`bundle exec sidekiq -C ./sidekiq.yml`

## Run frontend

`bundle exec thin start`
