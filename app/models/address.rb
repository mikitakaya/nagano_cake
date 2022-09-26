class Address < ApplicationRecord
 # address（N）はcustomer（1）に属する
 belongs_to :customer
 
 def address_display
  '〒' + postal_code + ' ' + address + ' ' + name
 end
end
