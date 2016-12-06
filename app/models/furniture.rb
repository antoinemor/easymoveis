class Furniture < ApplicationRecord
  has_many :listings
  has_many :bookings, through: :listings
  has_one :user, through: :listings

  validates :name,        presence: true
  validates :description, presence: true
  validates :category,    presence: true
end
