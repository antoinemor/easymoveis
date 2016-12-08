class Furniture < ApplicationRecord
  CATEGORY_OPTIONS = %w(Bed Chair Decoration Desk Dresser Ladder Table Sofa Other )

  belongs_to :user
  has_one :listing
  has_attachments :photos, maximum: 10

  validates :name,        presence: true
  validates :description, presence: true
  validates :category,    presence: true
  validates_inclusion_of :category, :in => CATEGORY_OPTIONS, :allow_nil => false
end
