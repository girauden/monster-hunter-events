# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts 'seed launching'
puts '  clean database'
User.destroy_all
Hunt.destroy_all
puts '  database cleansed'

puts '  create users'
user1 = User.create!(username: 'robert', password: 'qwerty', email: 'robert@mhw.io')
user2 = User.create!(username: 'bob', password: 'qwerty', email: 'bob@mhw.io')
user3 = User.create!(username: 'james', password: 'qwerty', email: 'james@mhw.io')
user4 = User.create!(username: 'edward', password: 'qwerty', email: 'edward@mhw.io')

users = [user1, user2, user3, user4]
puts '  users created'

puts '  create hunts'
qualifies = ['Super', 'Awesome', 'Funny', 'Cool', 'Dangerous', 'Incredible', 'Easy', 'Long', 'Fast', 'Serious']

words = ['Raid', 'Party', 'Try hard', 'Farm', 'Elimination', 'Game', 'Session', 'Hunt']

monsters = [
  'Deviljho', 'Vaal Hazak', 'Zinogre', 'Lunastra', 'Valstrax', 'Kushala Daora',
  'Kulve Taroth', 'Tigrex', 'Nergigante', "Xeno'jiiva", 'Fatalis', 'Kirin', 'Amatsu', 'Diablos'
]

platform = ['xbox', 'ps4', 'pc']
puts '  hunts already begin'
50.times do
  title = qualifies.sample + ' ' + words.sample + ' ' + monsters.sample
  Hunt.create!(title: title, datetime: rand(1..15).hour.ago, duration: rand(1..20), max_hunter: rand(2..20), platform: platform.sample, leader: users.sample)
end

puts '  hunts on coming'

50.times do
  title = qualifies.sample + ' ' + words.sample + ' ' + monsters.sample
  Hunt.create!(title: title, datetime: rand(1..10).hour.from_now, duration: rand(1..20), max_hunter: rand(2..20), platform: platform.sample, leader: users.sample)
end

puts '  hunts created'

puts 'seed ended'
