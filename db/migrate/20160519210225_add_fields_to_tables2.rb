class AddFieldsToTables2 < ActiveRecord::Migration
  def change
  	add_column :appartenances, :user_id, :integer
    add_column :appartenances, :matiere_id, :integer
    add_index :appartenances, [:user_id, :matiere_id]
  end
end
