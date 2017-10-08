class CreateProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|

      # property fields
      t.string        :type
      t.string        :name
      t.string        :address
      t.string        :district
      t.monetize      :value
      t.string        :deal # rent or sale
      t.decimal       :global_area, precision: 6, scale: 2
      t.decimal       :private_area, precision: 6, scale: 2

      # buildings fields
      t.integer       :profile
      t.integer       :position
      t.integer       :number_of_rooms
      t.monetize      :condominium

      # apartment fields
      t.integer       :number_of_boxes

      t.timestamps
    end
  end
end
