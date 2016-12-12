class Delivery < ApplicationRecord
  belongs_to :booking
  belongs_to :delivery_companies
end
