class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :role, null: false, default: "user"

      t.timestamps
    end
  end
end
