class Employee < ApplicationRecord
  belongs_to :school, :class_name => 'School' 
  belongs_to :role, :class_name => 'Role'
  has_many :shifts, dependent: :destroy
  # validation
  validates_presence_of :name
end
