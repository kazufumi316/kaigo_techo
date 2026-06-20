class CareUsersController < ApplicationController

  before_action :authenticate_user!
  
  def new
    @care_user = CareUser.new
    @family = @care_user.build_family
    @family.family_members.build(user: current_user, role: :main)
  end

  def create
    @care_user = CareUser.new(care_user_params)
    if @care_user.save
      redirect_to homes_path, success: t('要介護家族の登録に成功しました')
    else
      flash.now[:danger] = t('要介護家族の登録に失敗しました')
      render :new, status: :unprocessable_entity
    end
  end

  private

  def care_user_params
    params.require(:care_user).permit(
      :name, 
      :birthday, 
      :blood_type, 
      :medical_condition_1, 
      :medical_condition_2, 
      :medical_condition_3,
      family_attributes: [
        :family_name,
        family_members_attributes: [:user_id, :role]
      ]
    )
  end
end
