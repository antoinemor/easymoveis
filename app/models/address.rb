class Address < ApplicationRecord
  has_one :listing

  validates :address_line, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :country, presence: true

  geocoded_by :address_line
  after_validation :geocode
end
