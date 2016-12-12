class CreateDeliveryCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :delivery_companies do |t|
      t.string :name
      t.text :aaddress
      t.references :delivery, foreign_key: true

      t.timestamps
    end
  end
end
