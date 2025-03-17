class AddMemberIdToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :customer_id, :string
    add_index :members, :customer_id, unique: true
  end
end
