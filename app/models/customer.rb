class Customer < ApplicationRecord
  validates :email, presence: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\W]+\z/ }
end
