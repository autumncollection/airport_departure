class CreateCityTemperatures < ActiveRecord::Migration[6.0]
  def change
    create_table :city_temperatures do |table|
      table.integer :city_id, index: true
      table.integer :month, index: true
      table.float :temperature
    end
  end
end
