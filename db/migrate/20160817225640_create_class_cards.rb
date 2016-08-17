class CreateClassCards < ActiveRecord::Migration
  def change
    create_table :class_cards do |t|
    	t.belongs_to :card
    	t.belongs_to :class, class: 'Card'
      t.timestamps null: false
    end
  end
end
