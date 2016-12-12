class ChangePeriodsInListings < ActiveRecord::Migration[5.0]
  def change
    change_column :listings, :period_min, 'integer USING CAST(period_min AS integer)'
    change_column :listings, :period_max, 'integer USING CAST(period_max AS integer)'
  end
end
