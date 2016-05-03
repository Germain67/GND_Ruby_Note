# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
for i in 1..5
  u = User.new
  u.username = "user" + i.to_s
  u.password = "test"
  u.mail= "test.com"
  u.idRole= 1
  u.save
end