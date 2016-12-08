class AddAmbianceReferenceToListingAmbiance < ActiveRecord::Migration[5.0]
  def change
    add_reference :listing_ambiances, :ambiance, foreign_key: true
  end
end
