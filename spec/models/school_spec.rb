require 'rails_helper'

# Test suite for the School model
RSpec.describe School, type: :model do
  # Association test
  # ensure School model has a 1:m relationship with the employee model
  it { should have_many(:employees).dependent(:destroy) }
  # Validation tests
  # ensure columns name are present before saving
  it { should validate_presence_of(:name) }
end