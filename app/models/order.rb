class Order < ApplicationRecord
  attr_accessor :credit_card, :card_expiry_date, :card_expiry_year, :card_cvv, 
                :item, :items, :qty, :promocodes, :email, :address

  has_many :order_items, dependent: :destroy
  has_many :promotions, dependent: :destroy
  belongs_to :customer

  def calculate_order_price
    total = 0

    order_items.each do |order_item|
      total += order_item.item.price * order_item.qty.to_i
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

  def self.apply_promocode(codes, total_price)
    codes = codes.presence || [] 
    discount_price = total_price.to_f

    promocodes = if codes.length > 1 
                  Promocode.where(id: codes).where(used_in_conjuncation: true)
                 else
                  Promocode.where(id: codes)
                 end

    if promocodes.length == codes.length
      promocodes.each do |promo|
        if promo.flat?
          discount_price -= promo.value
        else
          discount_price -= (discount_price * (promo.value / 100))
        end
      end

      return '', true, total_price.to_f - discount_price
    else
      return 'You cant use these promocodes together', false, total_price.to_f - discount_price
    end
  end

  def generate_ref_no
    loop do
      ref_no = SecureRandom.base58(10)
      break ref_no unless Order.where(ref_no: ref_no).exists?
    end
  end

  def confirm!
    self.state = 'confirmed'
    self.ref_no = generate_ref_no
    save
  end
end
