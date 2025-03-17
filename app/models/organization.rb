class Organization < ApplicationRecord
    has_many :users
    has_many :services
    has_many :coupons
    has_many :members
  end
  