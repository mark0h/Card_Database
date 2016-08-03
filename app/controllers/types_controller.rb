class TypesController < ApplicationController

  def index
  	@types = Type.paginate(page: params[:page], per_page: 10)
  end

  def new
  	@type = Type.new
  end

  def create
  	@type = Type.new(type_params)
  	if @type.save
  		flash[:success] = "Type #{@type.name} successfully added"
  		redirect_to types_path
  	else
  		# flash[:danger] = "Tried to create using #{type_params}"
  		render 'new'
  	end
  end

  def show
  	@type = Type.find(params[:id])
  	@type_cards = @type.cards.paginate(page: params[:page], per_page: 10)
  end

  def edit
  end

  def update
  end

  private
  def type_params
  	params.require(:type).permit(:name)
  end

end
