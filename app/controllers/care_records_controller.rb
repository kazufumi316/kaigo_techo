class CareRecordsController < ApplicationController

  before_action :authenticate_user!

  def new
    @care_record = CareRecord.new
    @care_record.care_user_id = params[:care_user_id]
  end

  def create
    @care_record = current_user.care_records.build(care_record_params)
    if @care_record.save
      redirect_to care_records_path, success: '介護記録をつけました'
    else
      flash.now[:danger] = '介護記録ができませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def select
    if current_user.families.exists?
      family_ids = current_user.family_members.pluck(:family_id)
      @care_users = CareUser.where(family_id: family_ids)
    else
      @care_users = []
    end
  end

  def index
    @care_records = CareRecord.includes(:user, :care_user)
    if params[:care_user_id].present?
      @care_records = @care_records.where(care_user_id: params[:care_user_id])
      @care_user = CareUser.find(params[:care_user_id])
    end
  end

  private

  def care_record_params
    params.require(:care_record).permit(
      :health_status,
      :appetite,
      :sleep_quality,
      :memo,
      :care_user_id
    )
  end
end
