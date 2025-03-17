class CreateMembers < ActiveRecord::Migration[7.1]
  def change
    create_table :members, id: :uuid do |t|
      t.string :name
      t.string :email
      t.references :user, null: false, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
