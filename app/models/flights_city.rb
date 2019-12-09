require 'sinatra/activerecord'

class FlightsCity < ActiveRecord::Base
  belongs_to :city
  belongs_to :flight
end
