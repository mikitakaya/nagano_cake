class Order < ApplicationRecord
 enum order_status: { wait: 0, deposited: 1, make: 2, preparation: 3, sent: 4 }
end
