# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
{ 'Smart Hub' => 49.99, 'Motion Sensor' => 24.99, 'Wireless Camera' => 99.99, 
  'Smoke Sensor' => 19.99, 'Water Leak Sensor' => 14.99 }.each_pair do |key, value|
    Item.find_or_create_by(name: key, price: value)
  end

Promocode.find_or_create_by(name: '20%OFF', promo_type: 'percentage', value: 20.0, used_in_conjuncation: false)
Promocode.find_or_create_by(name: '5%OFF', promo_type: 'percentage', value: 5)
Promocode.find_or_create_by(name: '20POUNDSOFF', promo_type: 'flat', value: 20.0)
