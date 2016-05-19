class Matiere < ActiveRecord::Base
	resourcify
	has_many :epreuve, :dependent => :delete_all
	has_many :appartenances
	has_many :users, through: :appartenances
	validates :titre, presence: true
    validates :date_debut, presence: true
    validates :date_fin, presence: true
end
