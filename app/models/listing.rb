class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_one :furniture
  has_one :address
  validates :base_price, presence: true
end
