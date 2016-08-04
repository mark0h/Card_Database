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
    flash[:success] = "----params: #{params}\ncard_params: #{card_params}\ncard_traits_params: #{card_traits_params}"
    render 'index'

    @card = Card.new(card_params)
    # if @card.save
    #   flash[:success] = "#{@card.name} card successfully created"
    #   redirect_to cards_path
    # else
    #   render 'new'
    # end
  end

  def show
  end

  def edit
  end

  def destroy
  end

  def card_by_type
  end

  private
  def card_params
    params.require(:card).permit(:name, :type_id)
  end

  def card_traits_params
    params.require(:card_traits).permit(:trait_id, :card_id, :value)
  end

end
