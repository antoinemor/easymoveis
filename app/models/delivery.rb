class Delivery < ApplicationRecord
  belongs_to :booking
  has_one :user,    through: :booking
  has_one :listing, through: :booking
end
