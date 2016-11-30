require 'test_helper'

class FilterParameterTest < ActiveSupport::TestCase
  test 'should filter credit card informatio' do
    assert_equal [:password, :credit_card, :card_expiry_month, :card_expiry_year, :card_cvv], 
      Rails.application.config.filter_parameters  
  end
end 
