class OrderItem < ApplicationRecord
  validates :order_id, :item_id, presence: true
  validates_numericality_of :qty, greater_than: 0

  belongs_to :order
  belongs_to :item
end
