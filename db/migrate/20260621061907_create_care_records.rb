class CreateCareRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :care_records do |t|
      t.integer :health_status, null: false
      t.integer :appetite, null: false
      t.integer :sleep_quality, null: false
      t.string :memo
      t.references :care_user, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
