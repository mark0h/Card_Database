class CardController < ApplicationController

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
  end

  def create
  end

  def show
  end

  def edit
  end

  def destroy
  end

end
