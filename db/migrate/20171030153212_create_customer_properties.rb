class CreateCustomerProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_properties do |t|

      t.string   :name
      t.string   :phone
      t.string   :email
      t.string   :address
      t.integer  :kind
      t.integer  :deal # rent or sale

      t.datetime :read_at
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
