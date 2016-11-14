class CreateCardsInHands < ActiveRecord::Migration[5.0]
  def change
    create_table :cards_in_hands do |t|
      t.references :card, :hand, foreign_key: true
      t.timestamps
    end
  end
end
