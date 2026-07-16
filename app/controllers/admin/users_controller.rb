module Admin
  class UsersController < BaseController
    before_action :set_user, only: [ :show, :destroy ]

    def index
      @users = User.order(created_at: :desc)
      @users = @users.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?
      @users = @users.page(params[:page])
    end

    def show
      @care_users = @user.care_users
    end

    def destroy
      @user.destroy!
      redirect_to admin_users_path, notice: "ユーザーを削除しました", status: :see_other
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
