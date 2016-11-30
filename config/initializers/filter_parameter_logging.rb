# Be sure to restart your server when you modify this file.

# Configure sensitive parameters which will be filtered from the log file.
Rails.application.config.filter_parameters += [:password, :credit_card, :card_expiry_month, 
  :card_expiry_year, :card_cvv]
