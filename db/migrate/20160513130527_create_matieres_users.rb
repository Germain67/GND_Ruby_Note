class CreateMatieresUsers < ActiveRecord::Migration
  def change
    create_table :matieres_users, id: false do |t|
      t.belongs_to :matiere, index: true
      t.belongs_to :user, index: true
    end
  end
end
