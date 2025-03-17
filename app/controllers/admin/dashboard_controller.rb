class Admin::DashboardController < Admin::BaseController
  before_action :authenticate_user!
  skip_before_action :authorize_admin!

  def index
    @coupons = @current_organization.coupons
    @members = @current_organization.members
  end
  
end
