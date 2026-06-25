class ConnectCareUsersController < ApplicationController

  before_action :authenticate_user!

  def new;end
  
  def create
    care_user = CareUser.find_by(invite_code: params[:invite_code].upcase)

    if care_user
      current_user.family_members.create!(family_id: careuser.find_id)
      redirect_to care_users_path, success: "#{care_user.name}を登録しました"
    else
      flash.now[:danger] = "コードが違います"
      render :new, status: :unprocessable_entity
    end
  end
end
