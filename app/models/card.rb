class Card < ActiveRecord::Base
	belongs_to :type
	validates :name, presence: true, length: {minimum: 4, maximum: 50}
	validates :type_id, presence: true
end
