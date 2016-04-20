class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :mail
      t.integer :idRole

      t.timestamps null: false
    end
  end
end
