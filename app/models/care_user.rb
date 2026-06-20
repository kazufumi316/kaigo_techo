class CareUser < ApplicationRecord
  belongs_to :family
  has_many :care_records

  accepts_nested_attributes_for :family

  validates :name, presence: true
  validates :birthday, presence: true
  validates :medical_condition_1, length: { maximum: 50 }
  validates :medical_condition_2, length: { maximum: 50 }
  validates :medical_condition_3, length: { maximum: 50 }

  enum :blood_type, { 不明: 0, A型: 1, B型: 2, O型: 3, AB型: 4 }
end
