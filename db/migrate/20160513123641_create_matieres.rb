class CreateMatieres < ActiveRecord::Migration
  def change
    create_table :matieres do |t|
      t.string :titre
      t.date :date_debut
      t.date :date_fin

      t.timestamps null: false
    end
  end
end
