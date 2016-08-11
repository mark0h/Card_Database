module CardHelper

	def get_type_value(type_id)
		type = Type.find(type_id)
		type_value = type.name
	end

	def get_traits(card_id)
		@trait_values = Hash.new
		trait_list = CardTrait.where(card_id: card_id)

		trait_list.each do |trait|
			trait_info = Trait.find(trait.trait_id)
			trait_name = trait_info.name
			trait_id = trait_info.id
			trait_value = trait.value
			@trait_values[trait_name] = [trait_value, trait_id]
		end
	end
end
