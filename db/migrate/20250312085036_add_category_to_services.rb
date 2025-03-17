class AddCategoryToServices < ActiveRecord::Migration[7.1]
  def change
    add_column :services, :category, :integer
  end
end
