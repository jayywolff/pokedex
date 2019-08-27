# Seed the database by fetching all the Kanto pokemon and types from pokeapi.co
PokeApi::PokemonTypes.fetch
PokeApi::Pokemon.fetch_by_region(Pokemon::REGION)
