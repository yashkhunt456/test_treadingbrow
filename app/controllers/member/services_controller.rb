class Member::ServicesController < Member::BaseController 
  before_action :set_service, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @services = if params[:q].present?
      @current_organization.services.where("name ILIKE ?", "%#{params[:q]}%")
    else
      @current_organization.services
    end 
    @service = @current_organization.services.new
  end

  def show; end

  def new
    @service = @current_organization.services.build
  end

  def create
    @service = @current_organization.services.build(service_params)
    if @service.save
      redirect_to member_service_path(@service), notice: 'Service was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @service.update(service_params)
      redirect_to member_service_path(@service), notice: 'Service was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @service.destroy
    redirect_to member_services_path, notice: 'Service was successfully deleted.'
  end

  private

  def set_service
    @service = @current_organization.services.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :price, :duration, :image, :category)
  end
end

