class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.timestamps
    end
    add_reference :friendships, :metadata, null: false, foreign_key: { to_table: :friend_requests }, index: { unique: true }
  end
end
