class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.float :base_price
      t.references :furniture, foreign_key: true
      t.references :user, foreign_key: true
      t.references :address, foreign_key: true

      t.timestamps
    end
  end
end
