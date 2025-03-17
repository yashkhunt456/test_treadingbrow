class CreateOrganizations < ActiveRecord::Migration[7.1]
  def change
    create_table :organizations, id: :uuid do |t|
      t.string :name
      t.string :address
      t.string :phone

      t.timestamps
    end
  end
end
