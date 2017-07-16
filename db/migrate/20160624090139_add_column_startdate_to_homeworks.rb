class AddColumnStartdateToHomeworks < ActiveRecord::Migration[4.2]
  def change
    add_column :homeworks, :startdate, :integer
  end
end
