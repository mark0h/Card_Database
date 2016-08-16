require 'set'

module CardUtil 
  

  def debug_testing_log
    @@debug_testing_log ||= Logger.new("#{Rails.root}/log/debug_testing_log.log")
  end
  
  def self.remove_trait(params)
    debug_testing_log ||= Logger.new("#{Rails.root}/log/debug_testing_log.log")
		card_hash = params[:card]
    card_id = params[:id]
    removed_traits = []
    removed_traits = params[:traits_removed][:trait_name] if params[:traits_removed]
    update_results = ""

    card_hash.each do |k,v|
      debug_testing_log.info "k value: #{k}  v value: #{v}"

      if k == "temp_traits_attributes"
        @new_traits = []   #array to store each CardTrait object created, aferwards do a loop to save
        traits_to_add = "" #simple list to display what traits were added
        v.each do |key, value|
          trait_to_add_name = Trait.find(value[:id]).name
          traits_to_add += "#{trait_to_add_name} Value: '#{value[:value]}'"
          temp_trait = CardTrait.where(card_id: card_id, trait_id: "#{value[:id]}").first_or_create
          temp_trait.update(value: "#{value[:value]}")
          @new_traits << temp_trait
        end

        begin
          @new_traits.each do |x| x.save end #to save each CardTrait object created in above loop
        rescue
          render 'new'
        end 

        update_results += "The following traits were ADDED: #{traits_to_add}"
      else
        trait_id = Trait.where(name: k).first.id
        card_trait = CardTrait.where(card_id: card_id, trait_id: trait_id).first
        
        debug_testing_log.info "v value: #{v}  card_trait value: #{card_trait.value}"
        if v != card_trait.value
          next if removed_traits.include? k
          update_results += "The following traits were UPDATED: "
          update_results += "#{k} value is now #{v}  it was: #{card_trait.value}; "
          card_trait.update(value: v)       
        end   
      end        
      
    end

    if removed_traits.length > 0
      removed_traits.each do |trait|
        trait_id = Trait.where(name: trait).first.id
        trait_remove = CardTrait.where(card_id: card_id, trait_id: trait_id).first
        trait_remove.destroy
      end
      update_results += "The following traits were REMOVED: #{removed_traits.join(', ')}"
    end

    
    return update_results
		# removed_trait = CardTrait.where(card_id: card_id, trait_id: trait_id).first
		# removed_trait.destroy
	end

  def self.find_card(name)
    debug_testing_log ||= Logger.new("#{Rails.root}/log/debug_testing_log.log")
    debug_testing_log.info "Search card: #{name}"
    card = Card.where(name: name).first
    return card
  end

end