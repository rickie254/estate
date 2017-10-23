class CreateExtras < ActiveRecord::Migration[5.1]
  def change
    create_table :extras do |t|
      t.string  :descriptions, array: true, default: []
    end
  end
end
