class Order < ApplicationRecord
  attr_accessor :item, :qty, :promocode

  has_many :order_items, dependent: :destroy
  has_many :promotions, dependent: :destroy
  belongs_to :customer

  def calculate_order_price
    total = 0

    order_items.each do |order_item|
      total += order_item.item.price * order_item.qty
    end

    self.total_price = total
    self.price_after_discount = total

    if promotions.any?
      promotions.includes(:promocode).each do |promotion|
        promocode = promotion.promocode

        if promocode.flat?
          self.price_after_discount -= promocode.value
        else
          self.price_after_discount -= (self.price_after_discount * (promocode.value / 100))
        end
      end
      self.price_after_discount = 0 if self.price_after_discount < 0
    end

    save
  end

  def apply_promocode(codes = [])
    promocodes = if codes.length > 1 
                  Promocode.where(id: codes).where(used_in_conjuncation: true)
                 else
                  Promocode.where(id: codes)
                 end

    if promocodes.length == codes.length
      self.promotions.destroy_all

      promocodes.each do |promo|
        self.promotions.create(promocode: promo)
      end
      self.calculate_order_price

      return '', true
    else
      return 'You cant use promocodes together', false
    end
  end
end
