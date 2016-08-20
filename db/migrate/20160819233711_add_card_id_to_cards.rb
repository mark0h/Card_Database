class AddCardIdToCards < ActiveRecord::Migration
  def change
  	add_column :cards, :card_id, :integer
  end
end
