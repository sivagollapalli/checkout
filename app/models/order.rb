class Order < ApplicationRecord
  attr_accessor :item, :qty

  has_many :order_items
  belongs_to :customer

  def calculate_order_price
    total = 0

    order_items.each do |order_item|
      total += order_item.item.price * order_item.qty
    end

    self.total_price = total 
    self.price_after_discount = total
    save
  end
end
