class CareRecord < ApplicationRecord
  belongs_to :care_user
  belongs_to :user
  has_many :care_record_reads, dependent: :destroy

  enum :health_status, { 良い: 0, 変わらない: 1, 悪い: 2 }, prefix: true
  enum :appetite, { あり: 0, 変わらない: 1, ない: 2 }, prefix: true
  enum :sleep_quality, { 多い: 0, 変わらない: 1, 少ない: 2 }, prefix: true

  validates :health_status, presence: true
  validates :appetite, presence: true
  validates :sleep_quality, presence: true
  validates :memo, length: { maximum: 255 }
end
