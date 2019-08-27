class PokemonController < ApplicationController

  def index
    @region  = Pokemon::REGION
    @pokemon = Pokemon.includes(:types).all.map(&:as_json)
    @types   = Type.order(:name).pluck(:id, :name).to_h

    respond_to do |format|
      format.html { render :index }
      format.csv  { send_data Pokemon.to_csv }
      format.json { render json: @pokemon }
      format.xml  { render xml: @pokemon }
    end
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end
end
