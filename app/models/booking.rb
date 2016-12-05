class Booking < ApplicationRecord
  belongs_to :user
  has_many :listings
  has_many :furnitures, through: :listings
end
