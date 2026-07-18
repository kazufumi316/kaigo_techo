class CareRecordRead < ApplicationRecord
  belongs_to :care_record
  belongs_to :user

  validates :user_id, uniqueness: { scope: :care_record_id }
end
