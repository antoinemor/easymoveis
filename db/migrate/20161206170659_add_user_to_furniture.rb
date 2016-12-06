class AddUserToFurniture < ActiveRecord::Migration[5.0]
  def change
    add_reference :furnitures, :user, foreign_key: true
  end
end
