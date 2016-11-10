class CreateCards < ActiveRecord::Migration[5.0]
  def change
    create_table :cards do |t|
      t.string :suit
      t.integer :value
      t.string :img
      t.boolean :dealt
      t.references :hand, null: true

      t.timestamps
    end
  end
end
