class AddOrganizationToUsersServicesMembersCoupons < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :organization, type: :uuid, foreign_key: true, index: true
    add_reference :services, :organization, type: :uuid, foreign_key: true, index: true
    add_reference :members, :organization, type: :uuid, foreign_key: true, index: true
    add_reference :coupons, :organization, type: :uuid, foreign_key: true, index: true
  end
end
  