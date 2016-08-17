class ClassCard < ActiveRecord::Base
	belongs_to :card
	belongs_to :class, :class_name => 'Card'
end
