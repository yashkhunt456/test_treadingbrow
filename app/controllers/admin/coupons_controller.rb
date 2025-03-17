class Admin::CouponsController < Admin::BaseController
  before_action :set_coupon, only: %i[show edit update destroy]

  def index
    @coupons = if params[:q].present?
                 @current_organization.coupons.where("name ILIKE ?", "%#{params[:q]}%")
               else
                 @current_organization.coupons
               end 
    @services = @current_organization.services 
  end

  def show
  end

  def new
    @coupon = @current_organization.coupons.new
    @services = @current_organization.services 
  end

  def create
    @coupon = @current_organization.coupons.build(coupon_params)

    if @coupon.save
      save_coupon_services
      redirect_to admin_coupon_path(@coupon), notice: 'Coupon was successfully created.'
    else
      @services = @current_organization.services
      render :new
    end
  end

  def edit
    @services = @current_organization.services
  end

  def update
    if @coupon.update(coupon_params)
      @coupon.coupon_services.destroy_all  
      save_coupon_services
      redirect_to admin_coupon_path(@coupon), notice: 'Coupon was successfully updated.'
    else
      @services = @current_organization.services
      render :edit
    end
  end

  def destroy
    if @coupon&.member_coupons.exists?
      redirect_to admin_coupons_path, alert: 'Cannot delete this coupon. It is still assigned to one or more members.'
    else
      @coupon.destroy
      redirect_to admin_coupons_path, notice: 'Coupon deleted successfully.'
    end
  end

  private

  def set_coupon
    @coupon = @current_organization.coupons.find(params[:id])
  end

  def coupon_params
    params.require(:coupon).permit(:name, :discount, :services)
  end

  def save_coupon_services
    return unless params[:coupon][:services]

    params[:coupon][:services].each do |_index, service_params|
      service_id = service_params[:service_id]
      quantity = service_params[:quantity].to_i 
  
      next if quantity.zero?
  
      @coupon.coupon_services.create(service_id: service_id, quantity: quantity)
    end
  end
end
