class AddFieldsToTables < ActiveRecord::Migration
  def change
  	add_column :notations, :user_id, :integer
    add_column :notations, :epreuve_id, :integer
    add_column :notations, :note, :integer
    add_index :notations, [:user_id, :epreuve_id]
  end
end
