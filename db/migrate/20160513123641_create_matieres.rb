class CreateMatieres < ActiveRecord::Migration
  def change
    create_table :matieres do |t|
      t.string :titre
      t.timestamp :periode

      t.timestamps null: false
    end
  end
end
