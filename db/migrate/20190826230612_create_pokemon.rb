class CreatePokemon < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemon do |t|
      t.string     :name, null: false
      t.integer    :height
      t.integer    :weight
      t.string     :sprite
      t.string     :shape
      t.decimal    :capture_rate, default: 0.0, precision: 5, scale: 2
      t.timestamps
    end
  end
end
