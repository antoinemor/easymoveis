class ChangeFurnitureColName < ActiveRecord::Migration[5.0]
    rename_column :furnitures, :type, :category
  def change
  end
end
