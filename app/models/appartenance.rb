class Appartenance < ActiveRecord::Base
  belongs_to :matiere
  belongs_to :user
end
