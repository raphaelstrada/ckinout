class School < ApplicationRecord
    # model association
  has_many :employees, dependent: :destroy

  # validations
  validates_presence_of :name
end
