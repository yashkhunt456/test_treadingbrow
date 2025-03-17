class MakeUserIdOptionalInServicesCouponsMembers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :services, :user_id, true
    change_column_null :coupons, :user_id, true
    change_column_null :members, :user_id, true
  end
end
