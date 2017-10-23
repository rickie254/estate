class CreateGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :galleries do |t|
      t.integer :property_id
      t.string  :images, array: true, default: []

      t.timestamps
    end
  end
end
