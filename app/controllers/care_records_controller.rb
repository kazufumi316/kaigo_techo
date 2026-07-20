class CareRecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_care_record_session, only: [ :create_select_care_user, :save_day, :health_status, :appetite, :sleep_quality, :memo ]
  before_action :set_save_care_record_session, only: [ :save_create_select_care_user, :save_save_day, :save_health_status, :save_appetite, :save_sleep_quality ]
  before_action :set_care_record, only: [ :show, :edit, :update ]
  before_action :check_daily_record_limit, only: [ :create_select_care_user ]

  def create_select_care_user
    if current_user.families.count == 1
      family_ids = current_user.family_members.pluck(:family_id)
      @care_users = CareUser.where(family_id: family_ids)
      session[:care_record_attributes][:care_user_id] = @care_users.first.id
      redirect_to save_day_care_records_path and return
    elsif current_user.families.count > 1
      family_ids = current_user.family_members.pluck(:family_id)
      @care_users = CareUser.where(family_id: family_ids)
    else
      @care_users = []
    end
  end

  def save_create_select_care_user
    family_ids = current_user.family_members.pluck(:family_id)
    care_user_id = params[:care_record][:care_user_id]
    unless CareUser.where(family_id: family_ids).exists?(id: care_user_id)
      redirect_to create_select_care_user_care_records_path, alert: "見守り家族を選択してください"
      return
    end
    session[:care_record_attributes][:care_user_id] = care_user_id
    redirect_to save_day_care_records_path
  end

  def save_day;end

  def save_save_day
    session[:care_record_attributes][:save_day] = params[:care_record][:save_day]
    redirect_to health_status_care_records_path
  end

  def health_status
    family_ids = current_user.family_members.pluck(:family_id)
    @care_users = CareUser.where(family_id: family_ids)
  end

  def save_health_status
    session[:care_record_attributes][:health_status] = params[:care_record][:health_status]
    redirect_to appetite_care_records_path
  end

  def appetite;end

  def save_appetite
    session[:care_record_attributes][:appetite] = params[:care_record][:appetite]
    redirect_to sleep_quality_care_records_path
  end

  def sleep_quality;end

  def save_sleep_quality
    session[:care_record_attributes][:sleep_quality] = params[:care_record][:sleep_quality]
    redirect_to memo_care_records_path
  end

  def memo;end

  def create
    final_params = session[:care_record_attributes].merge(care_record_params.to_h)
    @care_record = current_user.care_records.build(final_params)
    if @care_record.save
      @care_record.care_record_reads.create!(user: current_user, read_at: Time.current)
      session.delete(:care_record_attributes)
      redirect_to homes_path, notice: "介護記録をつけました"
    else
      logger.error @care_record.errors.full_messages

      flash.now[:alert] = "介護記録が\n作成できませんでした"
      render :memo, status: :unprocessable_entity
    end
  end

  def view_select_care_user
    if current_user.families.count == 1
      family_ids = current_user.family_members.pluck(:family_id)
      @care_users = CareUser.where(family_id: family_ids)
      redirect_to care_records_path(care_user_id: @care_users.first.id) and return
    elsif current_user.families.count > 1
      family_ids = current_user.family_members.pluck(:family_id)
      @care_users = CareUser.where(family_id: family_ids)
      target_records = CareRecord.where(care_user_id: @care_users.pluck(:id)).where.not(user_id: current_user.id).where(created_at: 1.month.ago..)
      @unread_care_user_ids = target_records.where.not(id: current_user.care_record_reads.pluck(:care_record_id)).distinct.pluck(:care_user_id)
    else
      @care_users = []
    end
  end

  def index
    family_ids = current_user.family_members.pluck(:family_id)
    @care_users = CareUser.where(family_id: family_ids)
    if params[:care_user_id].present?
      unless @care_users.exists?(id: params[:care_user_id])
        redirect_to view_select_care_user_care_records_path, alert: "見守り家族を選択してください"
        return
      end
      @care_user = @care_users.find(params[:care_user_id])
      @care_records = CareRecord.includes(:user, :care_user).where(care_user_id: @care_user.id).order(save_day: :desc)
    else
      @care_records = CareRecord.none
    end

    @year = params[:year].to_i
    @month = params[:month].to_i
    if @year.zero? || @month.zero?
      @target_date = Time.current.to_date
    else
      begin
        @target_date = Date.new(@year, @month, 1)
      rescue ArgumentError
        @target_date = Time.current.to_date
      end
    end
    start_date = @target_date.beginning_of_month
    end_date = @target_date.end_of_month
    @reports = @care_records.where(save_day: start_date..end_date).order(save_day: :asc)
    @prev_month = @target_date.prev_month
    @next_month = @target_date.next_month
  end

  def show
    @care_user = @care_record.care_user
    @care_record.care_record_reads.find_or_create_by!(user: current_user) do |read|
      read.read_at = Time.current
    end
  end

  def edit;end

  def update
    if @care_record.update(care_record_params)
      redirect_to care_records_path(care_user_id: @care_record.care_user.id),
                  notice: "#{@care_record.save_day.strftime('%-m月%-d日')}\n介護記録を更新しました"
    else
      flash.now[:alert] = "介護記録の更新に\n失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    care_record = CareRecord.find(params[:id])
    if care_record.user_id != current_user.id
      redirect_to care_record_path(care_record), alert: "削除権限がありません"
      return
    end
    record_care_user_id = care_record.care_user_id
    record_save_day = care_record.save_day.strftime("%-m月%-d日")
    care_record.destroy!
    redirect_to care_records_path(care_user_id: record_care_user_id), notice: "#{record_save_day}\n介護記録を削除しました", status: :see_other
  end

  private

  def care_record_params
    params.require(:care_record).permit(
      :health_status,
      :appetite,
      :sleep_quality,
      :memo,
      :care_user_id,
      :save_day
    )
  end

  def set_care_record_session
    session[:care_record_attributes] ||= {}
    @care_record = CareRecord.new(session[:care_record_attributes])
  end

  def set_save_care_record_session
    session[:care_record_attributes] ||= {}
  end

  def set_care_record
    family_ids = current_user.family_members.pluck(:family_id)
    @care_record = CareRecord.joins(:care_user).where(care_users: { family_id: family_ids }).find(params[:id])
  end

  def check_daily_record_limit
    count = current_user.care_records.where(created_at: Date.current.all_day).count
    return if count < CareRecord::DAILY_RECORD_LIMIT

    redirect_to homes_path, alert: "1日の記録件数の上限(#{CareRecord::DAILY_RECORD_LIMIT}件)に達しています"
  end
end
