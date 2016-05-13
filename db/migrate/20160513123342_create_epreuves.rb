class CreateEpreuves < ActiveRecord::Migration
  def change
    create_table :epreuves do |t|
      t.string :titre
      t.date :date_examen

      t.timestamps null: false
    end
  end
end
