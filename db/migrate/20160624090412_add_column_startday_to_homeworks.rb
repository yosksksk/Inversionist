class AddColumnStartdayToHomeworks < ActiveRecord::Migration
  def change
    add_column :homeworks, :start_day, :string
  end
end
