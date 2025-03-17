class CreateServices < ActiveRecord::Migration[7.1]
  def change
    create_table :services, id: :uuid do |t|
      t.string :name
      t.decimal :price
      t.integer :duration
      t.references :user, null: false, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
