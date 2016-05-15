class Epreuve < ActiveRecord::Base
	resourcify
	belongs_to :matiere
	has_and_belongs_to_many :user
	validates :titre, presence: true
    validates :date_examen, presence: true
end
