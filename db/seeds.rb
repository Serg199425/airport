# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def random_string
  (0...10).map { (65 + rand(26)).chr }.join + '-' + rand(1000..10000).to_s
end

Airplane.create(model_name: 'airbus A380', registration_number: random_string)
Airplane.create(model_name: 'TU 144', registration_number: random_string)
Airplane.create(model_name: 'TU 100', registration_number: random_string)
Airplane.create(model_name: 'AH-2', registration_number: random_string)
Airplane.create(model_name: 'boeing 737', registration_number: random_string)
Airplane.create(model_name: 'boeing 747', registration_number: random_string)
Airplane.create(model_name: 'AH-225', registration_number: random_string)
Airplane.create(model_name: 'concord', registration_number: random_string)

(0..15).each do |number|
  User.create(email: 'user' + number.to_s + '@email.com', password: 'password')
end

AdminUser.create!(email: 'admin@mail.com', password: 'password', password_confirmation: 'password')
