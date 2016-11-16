class AddPositionToCardsInHands < ActiveRecord::Migration[5.0]
  def change
    add_column :cards_in_hands, :position, :integer
  end
end
