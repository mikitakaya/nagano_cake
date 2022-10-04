class Item < ApplicationRecord
 # Itemモデルに image を持たせる
 has_one_attached :image
 # item（N）はgenre（1）に属する
 belongs_to :genre
 # item（1）はcart_item（N）を複数持っている
 has_many :cart_items
 # item（1）はorder_detail（N）を複数持っている
 has_many :order_details

 validates :image, presence: true
 validates :name, presence: true
 validates :introduction, presence: true
 validates :genre_id, presence: true
 validates :price, presence: true

 enum is_active: { active: true, no_active: false }

 # 消費税を求めるメソッド
 def with_tax_price
  (price * 1.1).floor
 end

end