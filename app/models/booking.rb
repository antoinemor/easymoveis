class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  has_one :furniture, through: :listing
  has_one :delivery

  validate :start_date_before_end_date
  validate :start_date_before_past
  validates :user, uniqueness: { scope: :listing,
    message: "should happen once per user" }

  # Converting status into a text
  @workflowstep_list = {'E' => "Editing",
                      'R' => 'Rejected',
                      'D' => 'Closed',
                      'P' => 'Pending Approval',
                      'C' => 'Canceled',
                      'A' => 'Approved',
                      'T' => 'Rented',
                      'F' => 'Finished'}

  # Search for the booking and recovers it's status
  def self.text_wkf_step(step)

    resp = step.nil? ? 'Available' : @workflowstep_list[step]
  end

  private
   def start_date_before_end_date
     if self.start_date > self.end_date
       errors.add(:start_date, "Start date must be before end date")
     end
   end

   def start_date_before_past
     if self.start_date < Date.today
       errors.add(:start_date, "Start date must be since today")
     end
   end
end
