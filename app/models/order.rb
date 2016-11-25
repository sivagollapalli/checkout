class Order < ApplicationRecord
  validates :total_price, numericality: { only_integer: true, greater_than: 0.0 }
  validates :price_after_discount, numericality: { only_integer: true, greater_than_or_equal_to: 0.0 }
  validates_presence_of :customer_id
end
