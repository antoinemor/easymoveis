class Listing < ApplicationRecord

  PERIOD_OPTIONS = [3, 6, 9, 12, 18, 24]

  belongs_to :user
  has_many :bookings
  has_one :furniture, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :listing_ambiances, dependent: :destroy
  has_many :ambiances, through: :listing_ambiances

  accepts_nested_attributes_for :furniture
  accepts_nested_attributes_for :address

  validates :base_price, presence: true
  validates :period_min, presence: true
  validates :period_max, presence: true
  validates :deposit, presence: true

  validates_inclusion_of :period_min, :in => PERIOD_OPTIONS, :allow_nil => true
  validates_inclusion_of :period_max, :in => PERIOD_OPTIONS, :allow_nil => true

  validate :check_period_min_max


  def check_period_min_max
    if PERIOD_OPTIONS.index(period_min) > PERIOD_OPTIONS.index(period_max)
      errors.add(:period_min, "Incorrect Period" )
    end
  end

  def self.booked?
    Booking.where(listing_id: self.id).exists?
  end
end
