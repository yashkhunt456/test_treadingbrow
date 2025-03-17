class Member < ApplicationRecord
  belongs_to :organization
  has_many :member_services, dependent: :destroy
  has_many :services, through: :member_services
  has_many :member_coupons, dependent: :destroy
  has_many :coupons, through: :member_coupons
  before_save :initialize_coupon_services_quantity


  before_create :generate_unique_customer_id
  after_create :set_unique_customer_id

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  # validates :customer_id, uniqueness: true, presence: true

  def add_coupon_service_quantity(coupon_id, service_id, quantity)
    self.coupon_services_quantity ||= {}
    self.coupon_services_quantity["#{coupon_id}_#{service_id}"] = quantity
    save
  end

  def get_coupon_service_quantity(coupon_id, service_id)
    self.coupon_services_quantity["#{coupon_id}_#{service_id}"] || 0
  end
  def initialize_coupon_services_quantity
    self.coupon_services_quantity ||= {}
  end

  private

  def set_unique_customer_id
    update_column(:customer_id, generate_unique_customer_id) # Directly updates the column after creation
  end

  def generate_unique_customer_id
    self.customer_id = loop do
      random_id = rand(100000..999999).to_s # Generates a random 6-digit ID
      break random_id unless Member.exists?(customer_id: random_id) # Ensures uniqueness
    end
  end

end
