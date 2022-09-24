class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # customer（1）はaddress（N）を複数持っている
  has_many :addresses
  # customer（1）はcart_item（N）を複数持っている
  has_many :cart_items
  # customer（1）はorder（N）を複数持っている
  has_many :orders

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 会員フルネーム（漢字）用のメソッド
  def full_name
   self.last_name + " " + self.first_name
  end

  # 会員フルネーム（カナ）用のメソッド
  def full_name_kana
   self.last_name_kana + " " + self.first_name_kana
  end

  enum is_deleted: { no_active: true, active: false}
end
