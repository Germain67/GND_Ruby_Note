class Matiere < ActiveRecord::Base
	has_many :epreuve, :dependent => :delete_all
	has_and_belongs_to_many :user
	validates :titre, presence: true
    validates :date_debut, presence: true
    validates :date_fin, presence: true
end
