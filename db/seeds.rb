# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


_admin = Role.create(
    description: "Admin"
)
_supervisor = Role.create(
    description: "Supervisor"
)
_teacher = Role.create(
    description: "Teacher"
)

3.times do
    _school = School.create!(
        name:  Faker::FunnyName.name 
    ) 
    10.times do
        _employee = Employee.create!(
            school: _school,
            role: _teacher,
            name: Faker::Movies::StarWars.character,
            uid: Faker::Number.number(4),
            password: "1234" 
        )   
        _shift = Shift.create!(
            worked_from: Faker::Time.between(Date.today, Date.today, :morning),
            worked_to: Faker::Time.between(Date.today, Date.today, :afternoon),
            business_day: Date.today,
            snapshot_from: "",
            snapshot_to: "",
            employee: _employee
        )
    end
end