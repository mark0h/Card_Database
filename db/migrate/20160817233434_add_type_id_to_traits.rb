class AddTypeIdToTraits < ActiveRecord::Migration
  def change
  	add_column :traits, :type_id, :integer
  end
end
