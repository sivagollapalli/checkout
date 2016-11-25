class Promotion < ApplicationRecord
  validates :order_id, :item_id, presence: true
end
