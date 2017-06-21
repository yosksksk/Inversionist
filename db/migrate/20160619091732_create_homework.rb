class CreateHomework < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.string :subject
      t.string :object
      t.integer :page
      t.string :deadline
      t.timestamps null: false
    end
  end
end
