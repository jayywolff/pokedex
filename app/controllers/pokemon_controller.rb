class PokemonController < ApplicationController
  def index
    @region  = Pokemon::REGION
    @pokemon = Pokemon.includes(:types).all.map do |pokemon|
      pokemon.serializable_hash(include: :types)
    end
    @types   = Type.order(:name).pluck(:id, :name).to_h
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end
end
