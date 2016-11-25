class OrderItem < ApplicationRecord
  validates :order_id, :item_id, presence: true

  belongs_to :order
  belongs_to :item
end
