class CareRecordsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_care_record_session, only: [:create_select_care_user, :health_status, :appetite, :sleep_quality, :memo]

  def create_select_care_user
    if current_user.families.exists?
      family_ids = current_user.family_members.pluck(:family_id)
      @care_users = CareUser.where(family_id: family_ids)
    else
      @care_users = []
    end
  end

  def save_create_select_care_user
    session[:care_record_attributes] ||= {}
    session[:care_record_attributes] = { care_user_id: params[:care_record][:care_user_id]}
    redirect_to health_status_care_records_path
  end

  def health_status;end

  def save_health_status
    session[:care_record_attributes] ||= {}
    session[:care_record_attributes][:health_status] = params[:care_record][:health_status]
    redirect_to appetite_care_records_path
  end

  def appetite;end

  def save_appetite
    session[:care_record_attributes] ||= {}
    session[:care_record_attributes][:appetite] = params[:care_record][:appetite]
    redirect_to sleep_quality_care_records_path
  end

  def sleep_quality;end

  def save_sleep_quality
    session[:care_record_attributes] ||= {}
    session[:care_record_attributes][:sleep_quality] = params[:care_record][:sleep_quality]
    redirect_to memo_care_records_path
  end

  def memo;end

  def create
    final_params = session[:care_record_attributes].merge(care_record_params.to_h)
    @care_record = current_user.care_records.build(final_params)
    if @care_record.save
      session.delete(:care_record_attributes)
      redirect_to homes_path, notice: '介護記録をつけました'
    else
      logger.error @care_record.errors.full_messages

      flash.now[:alert] = "介護記録が\n作成できませんでした"
      render :memo, status: :unprocessable_entity
    end
  end

  def view_select_care_user
    if current_user.families.exists?
      family_ids = current_user.family_members.pluck(:family_id)
      @care_users = CareUser.where(family_id: family_ids)
    else
      @care_users = []
    end
  end

  def index
    @care_records = CareRecord.includes(:user, :care_user).order(created_at: :desc)
    if params[:care_user_id].present?
      @care_records = @care_records.where(care_user_id: params[:care_user_id])
      @care_user = CareUser.find(params[:care_user_id])
    end
  end

  def show
    @care_record = CareRecord.find(params[:id])
  end

  def edit
    @care_record = CareRecord.find(params[:id])
  end

  def update
    @care_record = CareRecord.find(params[:id])
    if @care_record.update(care_record_params)
      redirect_to care_records_path(care_user_id: @care_record.care_user.id),
                  notice: "#{@care_record.created_at.strftime('%-m月%-d日 %-H時%M分')}\n介護記録を更新しました"
    else
      flash.now[:alert] = "介護記録の更新に\n失敗しました"
      render :edit, status: :unprocessable_entity
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

  def set_care_record_session
    session[:care_record_attributes] ||= {}
    @care_record = CareRecord.new(session[:care_record_attributes])
  end
end
