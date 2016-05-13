class Matiere < ActiveRecord::Base
	has_many :epreuve
	has_and_belongs_to_many :user
	validates :titre, presence: true
    validates :periode, presence: true
end
