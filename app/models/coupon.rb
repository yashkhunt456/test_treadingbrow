class Coupon < ApplicationRecord
  belongs_to :organization

  has_many :coupon_services, dependent: :destroy
  has_many :services, through: :coupon_services
  has_many :member_coupons, dependent: :restrict_with_error

  validates :name, :discount, presence: true
end
