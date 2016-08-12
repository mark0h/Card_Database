class Card < ActiveRecord::Base
	belongs_to :type
	validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 4, maximum: 50}
	validates :type_id, presence: true
	has_many :card_traits
	has_many :traits, through: :card_traits

	#For adding traits in edit screen
	has_many :temp_traits
	accepts_nested_attributes_for :temp_traits, allow_destroy: true
end
