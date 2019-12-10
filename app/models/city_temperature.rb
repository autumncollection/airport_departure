require 'sinatra/activerecord'

class CityTemperature < ActiveRecord::Base
  belongs_to :city
end
