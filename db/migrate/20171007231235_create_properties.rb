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
      t.integer       :position

      # financial
      t.monetize      :value
      t.integer       :deal # rent or sale

      # booleans
      t.boolean       :is_featured
      t.boolean       :is_enterprise

      t.float         :global_area

      # buildings fields
      t.integer       :profile
      t.integer       :number_of_rooms
      t.float         :private_area

      # apartment fields
      t.integer       :number_of_boxes
      t.boolean       :roof
      t.monetize      :condominium, amount: { null: true, default: nil }

      # terrain fields
      t.integer       :terrain_kind

      # comercial fields
      t.integer       :comercial_kind

      t.datetime      :deleted_at

      t.timestamps
    end
  end
end
