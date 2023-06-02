# frozen_string_literal: true

class CreateFriendRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :friend_requests, &:timestamps
  end
end
