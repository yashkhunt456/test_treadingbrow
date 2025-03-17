class Service < ApplicationRecord
  belongs_to :organization
  has_many :coupon_services, dependent: :destroy
  has_many :coupons, through: :coupon_services
  has_many :member_services, dependent: :destroy
  has_one_attached :image

  enum category: { hair_services: 0, skin_care_services: 1, waxing_services: 2, other: 3 }

  def small_variant
    image.variant(resize_to_fill: [50, 50]).processed
  end

  def medium_variant
    image.variant(resize_to_fill: [300, 200]).processed
  end
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
