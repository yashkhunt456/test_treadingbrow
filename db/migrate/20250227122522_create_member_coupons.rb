class CreateMemberCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :member_coupons, id: :uuid do |t|
      t.references :member, null: false, foreign_key: true, type: :uuid
      t.references :coupon, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
