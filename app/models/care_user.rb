class CareUser < ApplicationRecord
  belongs_to :family
  has_many :care_records, dependent: :destroy

  accepts_nested_attributes_for :family

  before_validation :generate_invite_code, on: :create

  validates :name, presence: true
  validates :birthday, presence: true
  validates :blood_type, presence: true
  validates :medical_condition_1, length: { maximum: 50 }
  validates :medical_condition_2, length: { maximum: 50 }
  validates :medical_condition_3, length: { maximum: 50 }
  validates :invite_code, length: { is: 6 }
  validate :birthday_cannot_be_in_future

  enum :blood_type, { A型: 0, B型: 1, O型: 2, AB型: 3, 不明: 4 }

  private

  def birthday_cannot_be_in_future
    return if birthday.blank?
    errors.add(:birthday, "は未来の日付にできません") if birthday > Date.current
  end

  def generate_invite_code
    loop do
      self.invite_code = SecureRandom.alphanumeric(6).upcase
      break unless CareUser.exists?(invite_code: self.invite_code)
    end
  end
end
