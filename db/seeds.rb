require 'time'

start_time = Date.new(2020,9,27)
end_time = Date.new(2020,9,30)

5.times do
  Schedule.create!(
    body: Faker::Book.title,
    # color: 0,
    description: Faker::Book.title,
    start: start_time,
    start_year: start_time.year.to_i,
    start_month: start_time.month.to_i,
    start_date: start_time.day.to_i,
    end: end_time,
    end_year: end_time.year.to_i,
    end_month: end_time.month.to_i,
    end_date: end_time.day.to_i,
  )
end

5.times do
  List.create!(
    title: Faker::Book.title,
    )
  end
  
  3.times do
    Card.create!(
      id: rand(1..10),
      list_id: rand(1..10),
      body: Faker::Book.title,
      description: Faker::Book.title,
      status: rand(0..2),
      scheduled: rand(0..1),
      start: start_time,
      end: end_time,
      )
end
