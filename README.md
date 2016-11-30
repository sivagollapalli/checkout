[![Code
Climate](https://codeclimate.com/github/sivagollapalli/checkout/badges/gpa.svg)](https://codeclimate.com/github/sivagollapalli/checkout)

[![CircleCI](https://circleci.com/gh/sivagollapalli/checkout.svg?style=svg)](https://circleci.com/gh/sivagollapalli/checkout)

## Stack:

* Rails 5.0.0.1
* Ruby 2.3.0
* PostgreSQL 9.6

## Heroku URL:
  https://demo-ecom.herokuapp.com/

## Getting Started
* `bundle install`
* `bin/rails db:migrate`
* `bin/rails db:seed`
* `bin/rails test` (To run testcases)

## Assumptions:
* Assuming customer places order without login.
* Assuming every payment is successfull since there is no payment gateway.

## Schema
* Card(Stores customer card information in encrypted form)
* Customer
* Order
* OrderItem
* Promocode
* Promotion

## Promocode

* Every promocode is valid 
* Only two kinds of promocode supported i.e., Flat / Percentage 
