class CreateFriendships < ActiveRecord::Migration[6.1]
  def change
    create_table :friendships do |t|
      t.references :user,   null: false, foreign_key: true
      t.references :friend, null: false
      t.string :status, default: "pending"
      t.timestamps
    end
    # Add foreign key constraint for friend_id referencing users table
    add_foreign_key :friendships, :users, column: :friend_id
    add_index :friendships, [:user_id, :friend_id], unique: true
  end
end
