require 'test_helper'

class CardTest < ActiveSupport::TestCase
  test 'card information should be stored in encrypted format' do
    card = Card.create(credit_card: '1234567890123456', card_expiry_month: 8, 
                       card_expiry_year: 2020, card_cvv: 123)

    assert_equal BCrypt::Password.create(card.credit_card), card.credit_card 
    assert_equal BCrypt::Password.create(card.card_expiry_month), card.card_expiry_month
    assert_equal BCrypt::Password.create(card.card_expiry_year), card.card_expiry_year 
    assert_equal BCrypt::Password.create(card.card_cvv), card.card_cvv 
  end
end
