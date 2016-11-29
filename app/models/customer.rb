class Customer < ApplicationRecord
  validates :email, :address, presence: true
  validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/ }

  has_many :cards

  accepts_nested_attributes_for :cards
end
