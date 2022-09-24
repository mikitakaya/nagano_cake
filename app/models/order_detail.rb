class OrderDetail < ApplicationRecord
 # order_detail（N）はorder（1）に属する
 belongs_to :order
 # order_detail（N）はitem（1）に属する
 belongs_to :item

 enum crafting_status: { impossible: 0, wait: 1, make: 2, manufactured: 3 }
end
