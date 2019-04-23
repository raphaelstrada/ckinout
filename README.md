# Himama Clock-in and Clock-Out 

An important part of the HiMama platform is to allow teachers to clock-in/clock-out of their
daycare center. When a teacher arrives to work, they clock-in, when leave they clock-out, and
the platform keeps track of these events.


## Installation
```
$ git clone https://github.com/raphaelstrada/ckinout.git
$ cd ckinout
$ bundle
$ rails db:migrate
$ rails db:seed
$ rails s
# Open localhost:3000 in browser
```


# Run Capybara Tests
```
$ bundle exec rspec
```

