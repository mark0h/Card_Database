class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :type_id

      t.timestamps null: false
    end
  end
end
