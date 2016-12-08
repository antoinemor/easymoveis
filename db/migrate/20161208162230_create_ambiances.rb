class CreateAmbiances < ActiveRecord::Migration[5.0]
  def change
    create_table :ambiances do |t|
      t.references :listing_ambiance, foreign_key: true

      t.timestamps
    end
  end
end
