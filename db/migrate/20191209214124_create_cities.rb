class CreateCities < ActiveRecord::Migration[4.2]
  def change
    create_table :cities do |table|
      table.string :name, index: true
      table.float :temperature
    end
  end
end
