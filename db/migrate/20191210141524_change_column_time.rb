class ChangeColumnTime < ActiveRecord::Migration[6.0]
  def up
    rename_column :flights, :time, :schedule_time
    change_column :flights, :schedule_time, :datetime
  end

  def down
    rename_column :flights, :schedule_time, :time
    change_column :flights, :time, :time
  end
end
