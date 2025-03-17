class CreateCoupons < ActiveRecord::Migration[7.1]
  def change
    create_table :coupons, id: :uuid do |t|
      t.string :name
      t.decimal :discount
      t.references :user, null: false, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
