FactoryBot.define do
    factory :shift do
        worked_from { Faker::Time.between(Date.today, Date.today, :day) }
        worked_to { Faker::Time.between(Date.today, Date.today, :night) }
        business_day {Date.today}
        snapshot_from ""
        snapshot_to ""
        employee_id nil
    end
  end