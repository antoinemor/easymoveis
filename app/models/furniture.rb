class Furniture < ApplicationRecord
  belongs_to :user
  has_one :listing
  has_many :bookings, through: :listings
  has_attachments :photos, maximum: 10

  validates :name,        presence: true
  validates :description, presence: true
  validates :category,    presence: true
end
