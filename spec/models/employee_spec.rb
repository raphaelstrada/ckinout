require 'rails_helper'

# Test suite for the Employee model
RSpec.describe Employee, type: :model do
  # Association test
  it { should have_many(:shifts) }
  # ensure an Employee record belongs to a single school record
  it { should belong_to(:school) }
#   it { should belong_to(:roles) }
  # Validation test
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
#   it { should validate_presence_of(:password) }
end