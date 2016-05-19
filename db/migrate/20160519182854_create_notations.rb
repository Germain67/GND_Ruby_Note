class CreateNotations < ActiveRecord::Migration
  def change
    create_table :notations do |t|

      t.timestamps null: false
    end
  end
end
