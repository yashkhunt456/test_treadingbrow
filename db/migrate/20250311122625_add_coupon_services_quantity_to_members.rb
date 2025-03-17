class AddCouponServicesQuantityToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :coupon_services_quantity, :jsonb
  end
end
