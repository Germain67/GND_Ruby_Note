# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

matieres = Matiere.create!([{titre: 'Maths', date_debut: Date.new(2015,01,01), date_fin: Date.new(2016,01,02)}, {titre: 'Histoire', date_debut: Date.new(2014,06,10), date_fin: Date.new(2015,04,06)}, {titre: 'Français', date_debut: Date.new(2010,06,10), date_fin: Date.new(2012,04,06)}])
epreuve1 = Epreuve.create!(titre: 'controle1', date_examen: Date.new(2009,11,26), matiere: matieres.first)
epreuve2 = Epreuve.create!(titre: 'controle2', date_examen: Date.new(2019,11,26), matiere: matieres.first)
epreuve3 = Epreuve.create!(titre: 'controle3', date_examen: Date.new(2015,10,10), matiere: matieres.second)
epreuve4 = Epreuve.create!(titre: 'controle4', date_examen: Date.new(2016,10,10), matiere: matieres.third)
epreuve5 = Epreuve.create!(titre: 'controle5', date_examen: Date.new(2017,10,10), matiere: matieres.second)

# User pending
user3 = User.new
user3.nom = 'je veux'
user3.prenom = 'enseigner'
user3.email = 'pending@pending.com'
user3.password = 'pending123'
user3.password_confirmation = 'pending123'
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

user5 = User.new
user5.nom = 'Monsieur'
user5.prenom = 'Dupont'
user5.email = 'enseignant2@enseignant2.com'
user5.password = 'enseignant123'
user5.password_confirmation = 'enseignant123'
user5.save!
user5.add_role "enseignant"
user5.remove_role "pending"

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

for i in 1..6
  user4 = User.new
  user4.nom = 'Numé'
  user4.prenom = 'ro' + i.to_s
  user4.email = 'etudiant' + i.to_s + '@etudiant.com'
  user4.password = 'etudiant123'
  user4.password_confirmation = 'etudiant123'
  user4.save!
  user4.add_role "etudiant"
  user4.remove_role "pending"
end


# On créé des appartenances entre matières et user
appartenance1 = Appartenance.new
appartenance1.user_id = user1.id
appartenance1.matiere_id = matieres.first.id
appartenance1.save!

appartenance2 = Appartenance.new
appartenance2.user_id = user2.id
appartenance2.matiere_id = matieres.first.id
appartenance2.save!

appartenance3 = Appartenance.new
appartenance3.user_id = user5.id
appartenance3.matiere_id = matieres.second.id
appartenance3.save!

appartenance4 = Appartenance.new
appartenance4.user_id = user5.id
appartenance4.matiere_id = matieres.third.id
appartenance4.save!


# On créé des notes fictives
note1 = Notation.new
note1.user_id = user2.id
note1.epreuve_id = epreuve1.id
note1.note = '18'
note1.save!

note2 = Notation.new
note2.user_id = user2.id
note2.epreuve_id = epreuve2.id
note2.note = '13'
note2.save!

note3 = Notation.new
note3.user_id = user1.id
note3.epreuve_id = epreuve1.id
note3.save!

note4 = Notation.new
note4.user_id = user1.id
note4.epreuve_id = epreuve2.id
note4.save!

note5 = Notation.new
note5.user_id = user5.id
note5.epreuve_id = epreuve3.id
note5.save!

note6 = Notation.new
note6.user_id = user5.id
note6.epreuve_id = epreuve4.id
note6.save!

note7 = Notation.new
note7.user_id = user5.id
note7.epreuve_id = epreuve5.id
note7.save!

# Ability permettant de tester les permissions "can" de chaque utilisateur
# ability = Ability.new(user)
# ability1 = Ability.new(user1)
# ability2 = Ability.new(user2)
# ability3 = Ability.new(user3)