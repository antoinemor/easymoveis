class Listing < ApplicationRecord
  belongs_to :furniture
  has_many :bookings
end
