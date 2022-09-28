class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.integer :customer_id, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :name, null: false
      t.integer :shipping_fee, null: false
      t.integer :bill, null: false
      t.integer :payment_method, default: 0, null: false
      t.integer :order_status, default: 0, null: false

      t.timestamps
    end
  end
end
