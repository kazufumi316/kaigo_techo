class CareRecord < ApplicationRecord
  DAILY_RECORD_LIMIT = 10

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
  validates :save_day, presence: true

  before_validation :set_default_save_day, on: :create
  validate :daily_record_limit, on: :create

  private

  def set_default_save_day
    self.save_day ||= Date.current
  end

  def daily_record_limit
    return if user_id.blank?

    count = CareRecord.where(user_id: user_id, created_at: Date.current.all_day).count
    errors.add(:base, "1日の記録件数の上限(#{DAILY_RECORD_LIMIT}件)に達しています") if count >= DAILY_RECORD_LIMIT
  end
end
