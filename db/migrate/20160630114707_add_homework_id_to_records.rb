class AddHomeworkIdToRecords < ActiveRecord::Migration[4.2]
  def change
    add_column :records, :homework_id, :integer
  end
end
