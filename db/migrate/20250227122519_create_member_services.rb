class CreateMemberServices < ActiveRecord::Migration[7.1]
  def change
    create_table :member_services, id: :uuid do |t|
      t.references :member, null: false, foreign_key: true, type: :uuid
      t.references :service, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
