class CreateEpreuvesUsers < ActiveRecord::Migration
  def change
    create_table :epreuves_users, id: false do |t|
      t.integer :epreuve_id
      t.integer :user_id
    end
    execute "ALTER TABLE epreuves_users ADD PRIMARY KEY (epreuve_id, user_id);"
  end
end
