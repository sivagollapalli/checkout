class Promocode < ApplicationRecord
  validates :name, :value, :promo_type, presence: true
  validates :promo_type, inclusion: { in: %w(flat percentage) }
  validates :value, numericality: { greater_than: 0 }
end
