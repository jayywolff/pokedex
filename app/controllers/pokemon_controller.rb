class PokemonController < ApplicationController
  def index
    @region  = Pokemon::REGION
    @pokemon = PokeApi::Pokedex.fetch(@region)
    @types   = PokeApi::Type.fetch
  end

  def show
    @pokemon = PokeApi::Pokemon.fetch(params[:id])
  end
end
