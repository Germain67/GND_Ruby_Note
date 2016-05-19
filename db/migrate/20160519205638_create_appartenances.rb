class CreateAppartenances < ActiveRecord::Migration
  def change
    create_table :appartenances do |t|

      t.timestamps null: false
    end
  end
end
