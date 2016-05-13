class CreateMatieresUsers < ActiveRecord::Migration
  def change
    create_table :matieres_users, id: false do |t|
      t.integer :matiere_id
      t.integer :user_id
    end
    execute "ALTER TABLE matieres_users ADD PRIMARY KEY (matiere_id, user_id);"
  end
end
