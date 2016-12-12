class CreateDeliveries < ActiveRecord::Migration[5.0]
  def change
    create_table :deliveries do |t|
      t.string :status
      t.date :date
      t.float :price
      t.float :distance
      t.references :booking, foreign_key: true

      t.timestamps
    end
  end
end
