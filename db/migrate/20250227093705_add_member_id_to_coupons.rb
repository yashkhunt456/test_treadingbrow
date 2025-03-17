class AddMemberIdToCoupons < ActiveRecord::Migration[7.1]
  def change
    add_reference :coupons, :member, type: :uuid, foreign_key: true, null: true
  end
end
