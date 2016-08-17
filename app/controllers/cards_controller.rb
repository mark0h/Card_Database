class CardsController < ApplicationController
  include CardUtil

  def index
  	@cards = Card.paginate(page: params[:page], per_page: 10)
  end

  def search
    debug_testing_log ||= Logger.new("#{Rails.root}/log/debug_testing_log.log")
  	if params[:search_text]
  		@card = Card.where(name: name).first

      if @card
        debug_testing_log.info "Search card.id: #{@card.id} "
        # redirect_to card_path(@card.id)
        redirect_to "/cards/#{@card.id}"
      else
        flash[:danger] = "Card does not exist, but you can create it"
        redirect_to new_card_path, name: params[:search_text]
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
        @card_traits << CardTrait.where(card_id: @card.id, trait_id: "#{v[:id]}", value: "#{v[:value]}").first_or_create
      end

      begin
        @card_traits.each do |x| x.save end
      rescue
        render 'new'
      end      

      if params[:card_id]
        @card_class = ClassCard.where(card_id: @card.id, class_id: params[:card_id]).first_or_create
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
    @new_traits
  end

  def update

    update_results = CardUtil.remove_trait(params)
    flash[:success] = "#{update_results}" if update_results != ""
    # flash[:success] = "#{params}"  #For testing only, comment out above 2 lines when testing. 
    redirect_to card_path(params[:id]) 
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
