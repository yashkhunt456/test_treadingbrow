module ApplicationHelper
  def active_class(controller_name)
    "active" if params[:controller].include?(controller_name)
  end
end
