class CreateFlights < ActiveRecord::Migration[6.0]
  def change
    create_table :flights do |table|
      table.string :code, index: true
      table.string :note
      table.time :time
    end

    create_table :flights_cities do |table|
      table.integer :flight_id, index: true
      table.integer :city_id, index: true
    end
  end
end
