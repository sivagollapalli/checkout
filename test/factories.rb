FactoryGirl.define do
  factory :item do
    name 'First Item'
    price '20.0'
  end

  factory :promocode do
    name '20% OFF'
    promo_type 'percentage'
    value 20
  end
end
