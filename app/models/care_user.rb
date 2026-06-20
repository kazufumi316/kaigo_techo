class CareUser < ApplicationRecord
  belongs_to :family
  has_many :care_records

  validates :name, presence: true
  validates :birthday, presence: true
  validates :medical_condition_1, length: { maximum: 50 }
  validates :medical_condition_2, length: { maximum: 50 }
  validates :medical_condition_3, length: { maximum: 50 }

  enum :blood_type, { unknown: 0, a: 1, b: 2, o: 3, ab: 4 }
end
