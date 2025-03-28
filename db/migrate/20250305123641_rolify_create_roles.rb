class RolifyCreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table(:roles) do |t|
      t.string :name
      t.references :resource, polymorphic: true

      t.timestamps
    end

    create_table(:users_roles, id: false) do |t|
      t.references :user, type: :uuid, foreign_key: true
      t.references :role, foreign_key: true
    end
    
    add_index :roles, [:name, :resource_type, :resource_id]
    add_index :users_roles, [:user_id, :role_id]
  end
end
