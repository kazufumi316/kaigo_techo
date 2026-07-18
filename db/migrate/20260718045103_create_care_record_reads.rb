class CreateCareRecordReads < ActiveRecord::Migration[8.1]
  def change
    create_table :care_record_reads do |t|
      t.references :care_record, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :read_at, null: false

      t.timestamps
    end
    add_index :care_record_reads, [ :care_record_id, :user_id ], unique: true
  end
end
