class Member::DashboardController < Member::BaseController
  before_action :authenticate_user!
  skip_before_action :authorize_member!

  def index
   
  end
end
