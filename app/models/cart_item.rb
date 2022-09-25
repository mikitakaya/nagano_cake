class CartItem < ApplicationRecord
 # cart_item（N）はitem（1）に属する
 belongs_to :item
 # cart_item（N）はcustomer（1）に属する
 belongs_to :customer

 # 小計を求めるメソッド
 def subtotal
  item.with_tax_price * amount
 end
end
