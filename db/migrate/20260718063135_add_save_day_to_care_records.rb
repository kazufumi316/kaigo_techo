class AddSaveDayToCareRecords < ActiveRecord::Migration[8.1]
  def up
    add_column :care_records, :save_day, :date
    execute "UPDATE care_records SET save_day = created_at::date"
    change_column_null :care_records, :save_day, false
  end

  def down
    remove_column :care_records, :save_day
  end
end
