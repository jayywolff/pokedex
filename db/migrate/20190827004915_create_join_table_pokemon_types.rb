class CreateJoinTablePokemonTypes < ActiveRecord::Migration[6.0]
  def change
    create_join_table :pokemon, :types do |t|
      t.index [:pokemon_id, :type_id], unique: true
    end
  end
end
