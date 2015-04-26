# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'faker'

urls = []
#  Create a sample User
user = User.create(
  email: 'sample@user.com',
  password: '12345678',
  password_confirmation: '12345678'
)

# Create  5 sample urls
5.times  do
  new_url = Url.new(address: Faker::Internet.url)
  urls.push new_url
end

# assigning urls to the user
user.urls << urls

puts "Created user with email ID #{user.email} having  5 urls"