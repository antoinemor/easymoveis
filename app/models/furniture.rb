class Furniture < ApplicationRecord
  belongs_to :user
  has_one :listing
  has_many :bookings, through: :listings

  validates :name,        presence: true
  validates :description, presence: true
  validates :category,    presence: true
end
