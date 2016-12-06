class Address < ApplicationRecord
  belongs_to :listing
  validates :address, presence: true
  validates :city, presence: true
  validates :zip_code, presence: true
  validates :country, presence: true
end
