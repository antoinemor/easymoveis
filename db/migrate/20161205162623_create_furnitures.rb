class CreateFurnitures < ActiveRecord::Migration[5.0]
  def change
    create_table :furnitures do |t|
      t.string :name
      t.text :description
      t.string :category
      t.references :listing, foreign_key: true

      t.timestamps
    end
  end
end
