class Epreuve < ActiveRecord::Base
	resourcify
	belongs_to :matiere
	has_many :notations
	has_many :users, through: :notations
	attr_accessor :note
	attr_accessor :titre_matiere
	validates :titre, presence: true
    validates :date_examen, presence: true
end
