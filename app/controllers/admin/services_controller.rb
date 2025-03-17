class Admin::ServicesController < ApplicationController
  before_action :set_service, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @services = @current_organization.services
    @service = Service.new

    end
  
  def show; end


  def new
    @service = @current_organization.services.new
  end

  def create
    @service = @current_organization.services.new(service_params)

    if @service.save
      redirect_to admin_services_path, notice: "Service created successfully."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @service.update(service_params)
      redirect_to admin_services_path, notice: "Service updated successfully."
    else
      render :edit
    end
  end

  def destroy
    @service.destroy
    redirect_to admin_services_path, notice: "Service deleted successfully."
  end

  private

  def set_service
    @service = @current_organization.services.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :price, :duration, :category, :image)
  end

end   