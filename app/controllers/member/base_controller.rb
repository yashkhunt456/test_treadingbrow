class Member::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_member! 

  private

  def authorize_member!
    redirect_to admin_dashboard_index_path, alert: "Access denied!" unless current_user.has_role?(:member) || current_user.has_role?(:admin)
  end   
end
