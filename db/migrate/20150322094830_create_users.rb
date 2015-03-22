class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :uid, null: false, unique: true
      t.string :oauth_token, null: false

      t.timestamps null: false
    end
  end
end
