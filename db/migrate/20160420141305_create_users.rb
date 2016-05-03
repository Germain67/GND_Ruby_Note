class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nom
      t.string :prenom
      t.integer :idRole
    end
  end
end
