class ChangeRoleOfFamilyMembers < ActiveRecord::Migration[8.1]
  def change
    change_column_default :family_members, :role, from: nil, to: 1
  end
end
