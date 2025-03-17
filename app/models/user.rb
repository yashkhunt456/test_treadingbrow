class User < ApplicationRecord
  belongs_to :organization
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # has_many :services, dependent: :destroy
  # has_many :coupons, dependent: :destroy
  # has_many :members, dependent: :destroy
  # has_many :appointments, dependent: :destroy

  # validates :name, :email, :phone, presence: true
  # validates :email, uniqueness: true
  def admin?
    has_role?(:admin)
  end
  
end
  