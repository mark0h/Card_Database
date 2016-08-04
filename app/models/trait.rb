class Trait < ActiveRecord::Base
	validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {minimum: 3}
	has_many :card_traits
	has_many :cards, through: :card_traits
end
