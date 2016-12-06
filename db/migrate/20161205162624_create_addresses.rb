class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.text :address
      t.string :city
      t.string :zip_code
      t.string :country
      t.references :listing, foreign_key: true

      t.timestamps
    end
  end
end
