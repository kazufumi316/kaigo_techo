module Admin
  class DashboardController < BaseController
    def index
      @user_count = User.count
      @care_user_count = CareUser.count
      @care_record_count = CareRecord.count
    end
  end
end
