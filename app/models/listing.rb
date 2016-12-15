class Listing < ApplicationRecord
  PERIOD_OPTIONS = [3, 6, 9, 12, 18, 24]
  scope :available, ->(current_user) { where.not(user_id: current_user)  }

  include PgSearch
  pg_search_scope :global_search,
    associated_against: {
      furniture: [ :category ],
      address: [ :city ]
    }

  belongs_to :user
  has_one    :furniture,         dependent: :destroy
  has_one    :address,           dependent: :destroy
  has_many   :bookings,          dependent: :destroy
  has_many   :listing_ambiances, dependent: :destroy
  has_many   :ambiances,         through: :listing_ambiances

  validates :base_price, presence: true
  validates :period_min, presence: true
  validates :period_max, presence: true
  validates :deposit,    presence: true
  validates_inclusion_of :period_min, :in => PERIOD_OPTIONS, :allow_nil => true
  validates_inclusion_of :period_max, :in => PERIOD_OPTIONS, :allow_nil => true
  validate :check_period_min_max

  accepts_nested_attributes_for :furniture
  accepts_nested_attributes_for :address

  def check_period_min_max
    if PERIOD_OPTIONS.index(period_min) > PERIOD_OPTIONS.index(period_max)
      errors.add(:period_min, "Incorrect Period" )
    end
  end

  def self.booked?
    Booking.where(listing_id: self.id).exists?
  end

  def self.max_price
    max_price = 0
    Listing.all.each { |l| max_price = l.base_price if l.base_price > max_price }
    return max_price.round
  end
end
