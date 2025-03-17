class CouponService < ApplicationRecord
  belongs_to :coupon
  belongs_to :service

  validates :quantity, numericality: { greater_than: 0 }
end
