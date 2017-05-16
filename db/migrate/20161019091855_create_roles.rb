class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|

      t.timestamps null: false
      t.integer :user_id
      t.string :name
    end
  end
end
