class FamiliesController < ApplicationController

  before_action :authenticate_user!

  def new
    @family = Family.new
    @family_member = @family.family_members.new
    @care_user = @family.care_users.new
  end

  def create

end
