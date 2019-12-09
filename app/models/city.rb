require 'sinatra/activerecord'

class City < ActiveRecord::Base
  has_many :flight_cities
end
