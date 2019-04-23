class Role < ApplicationRecord
    # model association
  has_many :employees, dependent: :destroy

  # validations
  validates_presence_of :description
end
