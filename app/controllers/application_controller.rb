class ApplicationController < ActionController::Base
  before_action :set_current_organization

  private

  def set_current_organization
    @current_organization = current_user&.organization
  end

  helper_method :current_organization

  def current_organization
    @current_organization
  end
end
