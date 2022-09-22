class Item < ApplicationRecord
 has_one_attached :image
 belongs_to :genre
 enum is_active: { active: true, no_active: false }

 def with_tax_price
  (price * 1.1).floor
 end

 Item.count

end