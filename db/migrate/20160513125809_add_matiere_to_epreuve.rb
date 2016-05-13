class AddMatiereToEpreuve < ActiveRecord::Migration
  def change
    add_reference :epreuves, :matiere, index: true, foreign_key: true
  end
end
