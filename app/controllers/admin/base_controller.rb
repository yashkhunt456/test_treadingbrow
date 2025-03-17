class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin! 

  private

  def authorize_admin!
    unless current_user.has_role?(:admin)
      redirect_to member_services_path, alert: "You are not authorized to access the admin dashboard."
    end
  end
end
