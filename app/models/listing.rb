class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one :furniture, dependent: :destroy
  has_one :address
  validates :base_price, presence: true
  accepts_nested_attributes_for :furniture
end
