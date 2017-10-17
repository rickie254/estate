class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|

      # property fields
      t.string        :type
      t.string        :title
      t.integer       :gallery_id

      # location
      t.string        :address
      t.string        :district
      t.string        :nearby

      # financial
      t.monetize      :value
      t.integer       :deal # rent or sale

      t.decimal       :global_area, precision: 6, scale: 2
      t.decimal       :private_area, precision: 6, scale: 2

      t.boolean       :featured

      # buildings fields
      t.integer       :profile
      t.integer       :position
      t.integer       :number_of_rooms

      # apartment fields
      t.integer       :number_of_boxes
      t.boolean       :roof
      t.monetize      :condominium

      t.timestamps
    end
  end
end
