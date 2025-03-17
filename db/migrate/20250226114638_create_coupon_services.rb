class CreateCouponServices < ActiveRecord::Migration[7.1]
  def change
    create_table :coupon_services, id: :uuid do |t|
      t.references :coupon, null: false, foreign_key: true, type: :uuid
      t.references :service, null: false, foreign_key: true, type: :uuid
      t.integer :quantity

      t.timestamps
    end
  end
end
