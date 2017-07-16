class AddUseIdToHomeworks < ActiveRecord::Migration[4.2]
  def change
  add_column :homeworks, :user_id, :integer
  end
end
