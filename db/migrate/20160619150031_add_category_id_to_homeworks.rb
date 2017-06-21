class AddCategoryIdToHomeworks < ActiveRecord::Migration
  def change
    add_column :homeworks, :category_id, :integer
  end
end
