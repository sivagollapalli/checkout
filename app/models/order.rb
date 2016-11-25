class Order < ApplicationRecord
  attr_accessor :item, :qty

  has_many :order_items

  def calculate_order_price
    total = 0

    order_items.each do |order_item|
      total += order_item.item.price * order_item.qty
    end

    self.total_price = total 
    save
  end
end
