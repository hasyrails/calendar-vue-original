require 'time'


1.times do
  User.create!(
    name: 'hoge',
    email: 'hoge@mail.com',
    password: 'demopass',
    password_confirmation: 'demopass'
  )
end

