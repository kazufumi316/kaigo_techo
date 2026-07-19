class HomesController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    family_ids = current_user.family_members.pluck(:family_id)
    @care_users = CareUser.where(family_id: family_ids)

    family_care_user_ids = @care_users.pluck(:id)
    @target_care_records = CareRecord.where(care_user_id: family_care_user_ids).where.not(user_id: current_user.id)
    @unread_care_records = @target_care_records.where.not(id: current_user.care_record_reads.pluck(:care_record_id))
  end
end
