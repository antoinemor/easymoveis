class AddPeriodToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :periode, :string
  end
end
