class ChangeFurnitureColumnNameTypetoCondition < ActiveRecord::Migration[5.0]
  def change
    rename_column :furnitures, :type, :kind
  end
end
