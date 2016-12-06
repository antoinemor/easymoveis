class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :furnitures
  validates :base_price, presence: true
end
