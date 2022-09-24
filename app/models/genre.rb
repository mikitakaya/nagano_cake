class Genre < ApplicationRecord
 # ジャンル名のバリデーション設定
 validates :name, presence: true
 # genre（1）はitemを（N）複数持っている
 has_many :items
end
