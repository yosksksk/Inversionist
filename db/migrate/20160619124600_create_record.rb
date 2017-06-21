class CreateRecord < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :rsubject
      t.string :robject
      t.integer :rpage
      t.string :date
      t.timestamps null: false
    end
  end
end
