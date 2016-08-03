class CardTrait < ActiveRecord::Base
	belongs_to :card
	belongs_to :trait
end
