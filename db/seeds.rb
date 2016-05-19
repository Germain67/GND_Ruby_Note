# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

matieres = Matiere.create!([{titre: 'Maths', date_debut: Date.new(2015,01,01), date_fin: Date.new(2016,01,02)}, {titre: 'Histoire', date_debut: Date.new(2014,06,10), date_fin: Date.new(2015,04,06)}])
Epreuve.create!(titre: 'controle1', date_examen: Date.new(2009,11,26), matiere: matieres.first)
Epreuve.create!(titre: 'controle2', date_examen: Date.new(2019,11,26), matiere: matieres.first)

# User pending
user3 = User.new
user3.nom = 'je veux'
user3.prenom = 'enseigner'
user3.email = 'pending@pending.com'
user3.password = 'pending123'
user3.password_confirmation = 'pending123'
user3.add_role "pending"
user3.save!


# User admin
user = User.new
user.nom = 'ad'
user.prenom = 'min'
user.email = 'admin@admin.com'
user.password = 'admin123'
user.password_confirmation = 'admin123'
user.save!
user.add_role "admin"
user.remove_role "pending"

# User enseignant
user1 = User.new
user1.nom = 'ens'
user1.prenom = 'eignant'
user1.email = 'enseignant@enseignant.com'
user1.password = 'enseignant123'
user1.password_confirmation = 'enseignant123'
user1.save!
user1.add_role "enseignant"
user1.remove_role "pending"

# User etudiant
user2 = User.new
user2.nom = 'etu'
user2.prenom = 'diant'
user2.email = 'etudiant@etudiant.com'
user2.password = 'etudiant123'
user2.password_confirmation = 'etudiant123'
user2.save!
user2.add_role "etudiant"
user2.remove_role "pending"



# Ability permettant de tester les permissions "can" de chaque utilisateur
# ability = Ability.new(user)
# ability1 = Ability.new(user1)
# ability2 = Ability.new(user2)
# ability3 = Ability.new(user3)