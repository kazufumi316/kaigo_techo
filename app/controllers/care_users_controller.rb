class CareUsersController < ApplicationController

  before_action :authenticate_user!
  
  def new
    @care_user = CareUser.new
    @family = @care_user.build_family
    @family.family_members.build(user: current_user, role: :main)
  end

  def create
    @care_user = CareUser.new(care_user_params)
    family = @care_user.build_family(family_name: @care_user.name)
    family.family_members.build(user_id: current_user.id, role: "main")
    if @care_user.save
      redirect_to care_users_path, notice: '見守り家族の登録に成功しました'
    else
      logger.error @care_user.errors.full_messages
      flash.now[:alert] = "見守り家族の登録に\n失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def index
    if current_user.families.exists?
      family_ids = current_user.family_members.pluck(:family_id)
      @care_users = CareUser.where(family_id: family_ids)
    else
      @care_users = []
    end
  end

  def show
    family_ids = current_user.family_members.pluck(:family_id)
    @care_user = CareUser.where(family_id: family_ids).find(params[:id])
    @current_family_member = current_user.family_members.find_by(family_id: @care_user.family_id)
  end

  def edit
    family_ids = current_user.family_members.pluck(:family_id)
    @care_user = CareUser.where(family_id: family_ids).find(params[:id])
  end

  def update
    family_ids = current_user.family_members.pluck(:family_id)
    @care_user = CareUser.where(family_id: family_ids).find(params[:id])
    if @care_user.update(care_user_params)
      redirect_to care_users_path, notice: "見守り家族情報を\n更新しました"
    else
      flash.now[:alert] = "見守り家族の更新に\n失敗しました"
      render :edit, status: :unprocessable_entity
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
      :medical_condition_3
    )
  end
end
