module Admin
  class CareRecordsController < BaseController
    before_action :set_care_record, only: [ :show, :destroy ]

    def index
      @care_records = CareRecord.includes(:user, :care_user).order(created_at: :desc)
      if params[:care_user_name].present?
        @care_records = @care_records.joins(:care_user).where("care_users.name ILIKE ?", "%#{params[:care_user_name]}%")
      end
      if params[:user_name].present?
        @care_records = @care_records.joins(:user).where("users.name ILIKE ?", "%#{params[:user_name]}%")
      end
      @care_records = @care_records.page(params[:page])
    end

    def show
    end

    def destroy
      @care_record.destroy!
      redirect_to admin_care_records_path, notice: "介護記録を削除しました", status: :see_other
    end

    private

    def set_care_record
      @care_record = CareRecord.find(params[:id])
    end
  end
end
