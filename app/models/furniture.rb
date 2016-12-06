class Furniture < ApplicationRecord
  belongs_to :user
  has_many :listings
  has_many :bookings, through: :listings

  validates :name, uniqueness: true, presence: true, allow_blank: false
  validates :description, :type, presence: true, allow_blank: false
end
