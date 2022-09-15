class OrderDetail < ApplicationRecord
 enum crafting_status: { impossible: 0, wait: 1, make: 2, manufactured: 3 }
end
