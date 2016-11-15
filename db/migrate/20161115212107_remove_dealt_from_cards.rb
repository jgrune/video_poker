class RemoveDealtFromCards < ActiveRecord::Migration[5.0]
  def change
    remove_column :cards, :dealt, :boolean
  end
end
