class Genre < ApplicationRecord
 # ジャンル名のバリデーション設定
 validates :name, presence: true
 has_many :items, dependent: :destroy
end
