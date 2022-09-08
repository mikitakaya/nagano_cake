class Item < ApplicationRecord
 has_one_attached :image
 belongs_to :genre
 enum is_active: { active: true, noactive: false }
end
