class AddInviteCodeToCareUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :care_users, :invite_code, :string, null: false
    add_index :care_users, :invite_code, unique: true
    change_column_default :care_users, :blood_type, from: 0, to: nil
  end
end
