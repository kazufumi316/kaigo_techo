class CreateCareUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :care_users do |t|
      t.references :family, null: false, foreign_key: true
      t.string :name, null: false
      t.date :birthday, null: false
      t.integer :blood_type, null: false, default: 0
      t.string :medical_condition_1
      t.string :medical_condition_2
      t.string :medical_condition_3

      t.timestamps
    end
  end
end
