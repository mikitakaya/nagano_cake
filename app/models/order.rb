class Order < ApplicationRecord
 # order（N）はcustomer（1）に属する
 belongs_to :customer
 # order（1）はorder_detail（N）を複数持っている
 has_many :order_details

 # 小計を求めるメソッド
 def subtotal
  item.with_tax_price * amount
 end

 enum order_status: { wait: 0, deposited: 1, make: 2, preparation: 3, sent: 4 }
 enum payment_method: { credit_card: 0, transfer: 1 }
end
