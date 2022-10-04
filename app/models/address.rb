class Address < ApplicationRecord
 # address（N）はcustomer（1）に属する
 belongs_to :customer

 validates :name, presence: true
 validates :postal_code, presence: true
 validates :address, presence: true

 def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
 end
end
