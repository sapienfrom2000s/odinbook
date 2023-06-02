# frozen_string_literal: true

class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships, &:timestamps
    add_reference :friendships, :metadata, null: false, foreign_key: { to_table: :friend_requests },
                                           index: { unique: true }
  end
end
