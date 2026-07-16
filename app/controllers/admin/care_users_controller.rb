module Admin
  class CareUsersController < BaseController
    before_action :set_care_user, only: [ :show, :destroy ]

    def index
      @care_users = CareUser.order(created_at: :desc).page(params[:page])
    end

    def show
      @users = @care_user.family.family_members.includes(:user).map(&:user)
    end

    def destroy
      @care_user.family.destroy!
      redirect_to admin_care_users_path, notice: "見守り家族を削除しました", status: :see_other
    end

    private

    def set_care_user
      @care_user = CareUser.find(params[:id])
    end
  end
end
