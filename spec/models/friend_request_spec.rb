require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  context 'user 1 sends friend request to user 2' do
    it "builds association between FriendRequest and User" do
      user1 = users(:user1)
      user2 = users(:user2)
      expect(FriendRequest.new(sender_id:user1.id, receiver_id:user2.id).valid?).to be true
    end
  end
end