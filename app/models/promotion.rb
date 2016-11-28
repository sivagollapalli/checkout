class Promotion < ApplicationRecord
  validates :order_id, :promocode_id, presence: true

  belongs_to :promocode
  belongs_to :order
end
