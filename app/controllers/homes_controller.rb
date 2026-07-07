class HomesController < ApplicationController

  before_action :authenticate_user!

  def index
    @user = current_user
    family_ids = current_user.family_members.pluck(:family_id)
    @care_users = CareUser.where(family_id: family_ids)
  end
end