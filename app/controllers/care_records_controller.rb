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

  def index
    @care_records = CareRecord.includes(:user, :care_user)
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
