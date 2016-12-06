class Listing < ApplicationRecord
  belongs_to :furniture
  has_many :bookings
  validates :furniture, presence: true
  validates :base_price, presence: true
end
