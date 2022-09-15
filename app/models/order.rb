class Order < ApplicationRecord
 enum order_status: { wait: 0, deposited: 1, make: 2, preparation: 3, sent: 4 }
 enum payment_method: { credit_card: 0, transfer: 1 }
end
