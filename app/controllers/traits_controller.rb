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
