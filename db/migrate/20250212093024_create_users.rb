class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :name
      t.text :about
      t.string :profile_pic

      t.timestamps
    end
  end
end
