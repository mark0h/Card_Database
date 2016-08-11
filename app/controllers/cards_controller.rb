class CardsController < ApplicationController

  def index
  	@cards = Card.paginate(page: params[:page], per_page: 10)
  end

  def search
  	if params[:name]
  		@card = Card.find_by_name(params[:name])
  		if @card
  			redirect_to card_path(@card)
  		else
  			flash[:danger] = "Card does not exist, but you can create it"
  			redirect_to new_card_path, name: params[:name]
  		end
  	end
  end

  def new
  	@card = Card.new
    @card_traits = CardTrait.new
  end

  def create
    # card_name = card_params[:name]
    # card_type = card_params[:type_id]
    traits_to_add = ""
    params[:card][:traits_attributes].each do |k,v|
      traits_to_add += "ID: #{v[:id]} Value: #{v[:value]}, "
    end
    # flash[:success] = "#{card_name} -- Type: #{card_type} TRAITS: #{traits_to_add}"
    # render 'index'

    @card = Card.new(card_params)
    @card_traits = []
    if @card.save
      params[:card][:traits_attributes].each do |k,v|
        traits_to_add += "ID: #{v[:id]} Value: #{v[:value]}\n"
        @card_traits << CardTrait.new(card_id: @card.id, trait_id: "#{v[:id]}", value: "#{v[:value]}")
      end

      begin
        @card_traits.each do |x| x.save end
      rescue
        render 'new'
      end      
      
      flash[:success] = "#{@card.name} card successfully created. TRAITS: #{traits_to_add}"
      redirect_to cards_path
    else
      render 'new'
    end
  end

  def show
    @card = Card.find(params[:id])
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update 
    card_hash = params[:card]
    card_id = params[:id]    

    card_hash.each do |k,v|
      trait_id = Trait.where(name: k).first.id
      card_trait = CardTrait.where(card_id: card_id, trait_id: trait_id).first

      if v != card_trait.value
        update_test = "Updating Card id: #{card_id} with::: "
        update_test += "#{k} value is now #{v}  it was: #{card_trait.value}; "
        card_trait.update(value: v)
        flash[:success] = "#{update_test}"        
      end
      
    end

    
    redirect_to card_path(card_id) 
  end

  def destroy
  end

  def card_by_type
  end

  private
  def card_params
    params.require(:card).permit(:name, :type_id)
  end

  # def card_traits_params
  #   params.require(:card_traits).permit(:trait_id, :card_id, :value)
  # end

end
