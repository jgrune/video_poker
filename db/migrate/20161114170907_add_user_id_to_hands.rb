class AddUserIdToHands < ActiveRecord::Migration[5.0]
  def change
    add_reference :hands, :user, foreign_key: true
  end
end
