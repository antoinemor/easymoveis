class Furniture < ApplicationRecord
  belongs_to :user
  has_many :listings
  has_many :bookings, through: :listings
end
