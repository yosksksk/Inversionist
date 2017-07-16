class AddCategoryIdToHomeworks < ActiveRecord::Migration[4.2]
  def change
    add_column :homeworks, :category_id, :integer
  end
end
