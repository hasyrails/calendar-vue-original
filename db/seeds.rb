require 'time'

start_time = Time.new(2020,9,27)
end_time = Time.new(2020,9,30)

5.times do
  Schedule.create!(
    title: Faker::Book.title,
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
    list_id: 1,
    title: Faker::Book.title,
    body: Faker::Book.title,
  )
end
