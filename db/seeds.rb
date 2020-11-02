require 'time'


1.times do
  User.create!(
    name: 'hoge',
    email: 'hoge@mail.com',
    password: 'demopass',
    password_confirmation: 'demopass',
  )
end

3.times do
  List.create!(
    title: 'hoge',
    user_id: 1
  )
end

