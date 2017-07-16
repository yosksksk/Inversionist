class AddColumnStartdayToHomeworks < ActiveRecord::Migration[4.2]
  def change
    add_column :homeworks, :start_day, :string
  end
end
