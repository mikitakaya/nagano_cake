class Address < ApplicationRecord
 # address（N）はcustomer（1）に属する
 belongs_to :customer
end
