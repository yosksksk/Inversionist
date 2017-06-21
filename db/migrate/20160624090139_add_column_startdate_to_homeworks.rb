class AddColumnStartdateToHomeworks < ActiveRecord::Migration
  def change
    add_column :homeworks, :startdate, :integer
  end
end
