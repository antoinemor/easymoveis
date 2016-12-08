class AddPeriodMaxToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :period_max, :string
  end
end
