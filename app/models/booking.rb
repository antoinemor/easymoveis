class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  has_one :furniture, through: :listing
  has_one :delivery, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :user, uniqueness: { scope: :listing, message: "should happen once per user" }

  validate :start_date_before_past

  accepts_nested_attributes_for :delivery

  # Converting status into a text
  @workflowstep_list = {'E' => "Editing",
                      'R' => 'Rejected',
                      'D' => 'Closed',
                      'P' => 'Pending Approval',
                      'C' => 'Canceled',
                      'A' => 'Approved',
                      'T' => 'Rented',
                      'F' => 'Finished',
                      'V' => 'Available'}

  # Search for the booking and recovers its status
  def self.text_wkf_step(step)
    resp = step.nil? ? 'Available' : @workflowstep_list[step]
  end

  private

  def start_date_before_past
    unless self.start_date.nil?
      errors.add(:start_date, "The start date can't be in less than three days") if self.start_date < Date.today + 3
    end
  end
end
