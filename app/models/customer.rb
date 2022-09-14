class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
