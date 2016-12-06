class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  has_one :furniture, through: :listing
end
