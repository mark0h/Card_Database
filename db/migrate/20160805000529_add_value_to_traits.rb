class AddValueToTraits < ActiveRecord::Migration
  def change
  	add_column :traits, :value, :string
  end
end
