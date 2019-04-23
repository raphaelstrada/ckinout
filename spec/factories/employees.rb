FactoryBot.define do
    factory :employee do
        name { Faker::Movies::StarWars.character }
        uid { Faker::Number.number(4) }
        password {Faker::Number.number(4)}
        school_id nil
        role_id nil
    end
  end