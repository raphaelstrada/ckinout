require 'rails_helper'

# Test suite for the School model
RSpec.describe Shift, type: :model do
  it { should belong_to(:employee) }
  # Association test
  # ensure School model has a 1:m relationship with the employee model
  # Validation tests
  # ensure columns name are present before saving
  # it { should validate_presence_of(:name) }
end