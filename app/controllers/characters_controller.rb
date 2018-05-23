class CharactersController < ApplicationController
  include Roll

  skip_before_action :verify_authenticity_token

  before_action :set_character, only: [:show, :edit, :update, :destroy]

  def index
    @characters = Character.all

    if params[:q].present?
      @q          = params[:q]
      @characters = Character.where('name ILIKE ?', "%#{@q}%")
    end
  end

  def show
  end

  def new
    store_stats

    @stat_array = session[:stat_array]
    @character  = Character.new
  end

  def edit
  end

  def create
    @character = Character.new(character_params)

    if @character.save
      redirect_to @character, notice: 'Character was successfully created.'
    else
      render :new
    end
  end

  def update
    if @character.update(character_params)
      redirect_to @character, notice: 'Character was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @character.destroy

    redirect_to characters_url, notice: 'Character was successfully destroyed.'
  end

  private

  def set_character
    @character = Character.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:name, :description, :strength, :dexterity, :endurance, :intelligence, :education, :social)
  end
end
