class CareRecordWizardsController < ApplicationController

  before_action :authenticate_user!
  include Wicked::Wizard

  steps :select_care_user, :health_status, :appetite, :sleep_quality, :memo


  def show
    session[:care_record_attributes] ||= {}
    @care_record = CareRecord.new(session[:care_record_attributes])
    case step
    when :select_care_user
      @care_users = current_user.care_users.present? ? current_user.care_users : []
    end

    render_wizard
  end

  def update
    session[:care_record_attributes] ||= {}
    if params[:care_record].present?
      session[:care_record_attributes].merge!(care_record_params.to_h)
    end

    if step == :memo
      @care_record = current_user.care_records.build(session[:care_record_attributes])

      if @care_record.save
        session[:care_record_attributes] = nil
        redirect_to care_records_path, success: '介護記録をつけました'
      else
        flash.now[:danger] = '介護記録ができませんでした'
        render_wizard @care_record and return
      end
    end

    redirect_to wizard_path(next_step)
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
