class AddPhoneToProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :phone, :string
  end
end
