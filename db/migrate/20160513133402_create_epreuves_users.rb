class CreateEpreuvesUsers < ActiveRecord::Migration
  def change
    create_table :epreuves_users, id: false do |t|
      t.belongs_to :epreuve, index: true
      t.belongs_to :user, index: true
    end
  end
end
