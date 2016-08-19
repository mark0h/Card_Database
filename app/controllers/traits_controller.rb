class TraitsController < ApplicationController

  def index
  	@traits = Trait.paginate(page: params[:page], per_page: 10)
  end

  def new
  	@trait = Trait.new
  end

  def create
  	@trait = Trait.new(trait_params)
  	if @trait.save
  		redirect_to traits_path
  	else
  		render 'new'
  	end
  end

  def show
    @trait = Trait.find(params[:id])
    card_ids = CardTrait.where(trait_id: params[:id])
    @card_list = []
    card_ids.each do |card_trait|
      @card_list << Card.find(card_trait.card_id)
    end
  end

  def edit
  end

  def update
  end

  private
  def trait_params
  	params.require(:trait).permit(:name)
  end
  
end
