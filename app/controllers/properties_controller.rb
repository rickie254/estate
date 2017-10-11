class PropertiesController < ApplicationController
  # before_action :authenticate_admin!, :except => [:index]

  def index
  end
  def show
  end
  def new
    @property = property_type.new
    render "properties/#{params[:type].downcase}_form"
  end

  # def index
  #   if admin_signed_in?
  #     @games = Game.all.order(title: :asc)
  #   else
  #     @games = Game.where(available: true).order(title: :asc)
  #   end
  # end
  #
  # def edit
  #   @game = Game.find params[:id]
  # end

  def create
    @property = property_type.new property_params

    if @property.save
      redirect_to @property
    else
      render "properties/#{params[:type].downcase}_form"
    end
  end

  # def update
  #   game = Game.find params[:id]
  #
  #   if game.update game_params
  #     redirect_to root_path
  #   else
  #     @game = game
  #     render :edit
  #   end
  # end

  private

  def property_params
    params.require(params[:type].downcase.to_sym).permit(:title, :address, :district, :value, :deal,
    :global_area, :private_area, :featured, :profile, :position, :number_of_rooms, :condominium)
  end

  def property_type
    params[:type].constantize if params[:type].in? property_types
  end

  def property_types
    ["House"]
  end
end
