class CreateCardTraits < ActiveRecord::Migration
  def change
    create_table :card_traits do |t|
      t.integer :card_id
      t.integer :trait_id
      t.string :value

      t.timestamps null: false
    end
  end
end
