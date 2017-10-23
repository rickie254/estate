class CreateExtraLists < ActiveRecord::Migration[5.1]
  def change
    create_table :extra_lists do |t|
      t.integer :property_id
      t.string  :list, array: true, default: []
      
      t.timestamps
    end
  end
end
