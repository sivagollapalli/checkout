class Card < ApplicationRecord
  belongs_to :customer

  validates :credit_card, :card_expiry_date, :card_expiry_year, :card_cvv, 
            presence: true
  validates :card_cvv, :credit_card, format: { with: /[0-9]/, message: 'Enter only numbers' }

  before_create :encrypt_card_info

  private 

  def encrypt_card_info
    self.credit_card = BCrypt::Password.create(credit_card) 
    self.card_expiry_year = BCrypt::Password.create(card_expiry_year) 
    self.card_expiry_date = BCrypt::Password.create(card_expiry_date) 
    self.card_cvv = BCrypt::Password.create(card_cvv) 
  end
end
