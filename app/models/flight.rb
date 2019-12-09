require 'sinatra/activerecord'

class Flight < ActiveRecord::Base
  has_many :flight_cities
end
