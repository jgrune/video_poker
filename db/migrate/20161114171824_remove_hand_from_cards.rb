class RemoveHandFromCards < ActiveRecord::Migration[5.0]
  def change
    remove_column :cards, :hand_id, :integer
  end
end
