class Admin::MembersController < Admin::BaseController
  before_action :set_member, only: %i[show edit update destroy]

  def index
    @member = Member.new
    @coupons = current_organization.coupons.all
    @members = if params[:q].present?
                 @current_organization.members.where("name ILIKE ?", "%#{params[:q]}%")
               else
                 @current_organization.members
               end
  end

  def show
  end

  def new
    @member = @current_organization.members.new
    load_services_and_coupons
  end

  def create
    @member = @current_organization.members.new(member_params)
    if @member.save!
      update_services_and_coupons
      redirect_to admin_member_path(@member), notice: "Member was successfully created."
    else
      load_services_and_coupons
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    load_services_and_coupons
  end

  def update
    if @member.update(member_params)
      update_services_and_coupons
      redirect_to admin_member_path(@member), notice: "Member was successfully updated."
    else
      load_services_and_coupons
      render :edit, status: :unprocessable_entity
    end
  end

  def redeem
    @member = Member.find(params[:id])
    coupon_id = params[:coupon_id]
    service_id = params[:service_id]

    if @member.coupon_services_quantity.present? && @member.coupon_services_quantity[coupon_id].is_a?(Hash)
      new_quantity = @member.coupon_services_quantity[coupon_id][service_id].to_i - 1

      if new_quantity <= 0
        @member.coupon_services_quantity[coupon_id].delete(service_id)
        @member.coupon_services_quantity.delete(coupon_id) if @member.coupon_services_quantity[coupon_id].empty?
      else
        @member.coupon_services_quantity[coupon_id][service_id] = new_quantity
      end

      @member.save!

      service = Service.find_by(id: service_id)
      MemberMailer.redemption_notification(@member, service, new_quantity).deliver_later
    end

    redirect_to admin_members_path, notice: "Redeemed successfully!"
  end

  def destroy
    @member.destroy
    redirect_to admin_members_path, notice: "Member was successfully deleted."
  end

  private

  def set_member
    @member = @current_organization.members.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :email, :phone, service_ids: [], coupon_ids: [])
  end

  def update_services_and_coupons
    selected_coupons = params[:member][:coupon_ids].reject(&:blank?)
    @member.coupons = @current_organization.coupons.where(id: selected_coupons)

    coupon_services_quantity = {}

    selected_coupons.each do |coupon_id|
      services_with_quantities = CouponService.where(coupon_id: coupon_id).pluck(:service_id, :quantity)

      services_with_quantities.each do |service_id, quantity|
        coupon_services_quantity[coupon_id] ||= {}
        coupon_services_quantity[coupon_id][service_id] = quantity
      end
    end

    @member.update(coupon_services_quantity: coupon_services_quantity)
  end

  def load_services_and_coupons
    @services = @current_organization.services
    @coupons = @current_organization.coupons
  end
end
