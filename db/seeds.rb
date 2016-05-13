# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

matieres = Matiere.create!([{titre: 'Maths', periode: Time.new(2002)}, {titre: 'Histoire', periode: Time.new(2002)}])
Epreuve.create!(titre: 'controle1', date_examen: Date.new(2009,11,26), matiere: matieres.first)
Epreuve.create!(titre: 'controle2', date_examen: Date.new(2019,11,26), matiere: matieres.first)

user = User.new
user.email = 'admin@admin.com'
user.password = 'admin123'
user.password_confirmation = 'admin123'
user.save!