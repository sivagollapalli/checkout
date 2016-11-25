class Promocode < ApplicationRecord
  validates :name, :value, :type, presence: true
  validates :type, inclusion: { in: %w(flat percentage) }
  validates :value, numericality: { only_integer: true, greater_than: 0 }
end
