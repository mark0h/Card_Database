class AddCardIdToTempTraits < ActiveRecord::Migration
  def change
  	add_column :temp_traits, :card_id, :integer
  end
end
