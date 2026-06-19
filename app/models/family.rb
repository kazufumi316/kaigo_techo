class Family < ApplicationRecord
  has_many :family_members, dependent: :destroy
  has_many :care_users, dependent: :destroy
end
