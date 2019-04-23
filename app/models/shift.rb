class Shift < ApplicationRecord
  has_many_attached :uploads

  belongs_to :employee
  # validation
  validates_presence_of :worked_from
end
