class AddHomeworkIdToRecords < ActiveRecord::Migration
  def change
    add_column :records, :homework_id, :integer 
  end
end
