class CreateListings < ActiveRecord::Migration[5.0]
  def change
    create_table :listings do |t|
      t.float :base_price
      t.references :furniture, foreign_key: true

      t.timestamps
    end
  end
end
