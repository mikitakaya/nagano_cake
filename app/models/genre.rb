class Genre < ApplicationRecord
 # ジャンル名のバリデーション設定
 validates :name, presence: true
end
