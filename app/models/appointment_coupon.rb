class AppointmentCoupon < ApplicationRecord
  belongs_to :appointment
  belongs_to :coupon
end
