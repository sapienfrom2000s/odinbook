# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'when request is accepted' do
    it 'creates association with the FriendRequest model' do
      user1 = create(:user)
      user2 = create(:user)
      FriendRequest.create(sender_id: user1.id, receiver_id: user2.id)
      frienship = Friendship.new
      frienship.metadata = FriendRequest.first
      expect { frienship.save }.to(change { Friendship.count })
    end
  end

  context 'when friend request is rejected' do
    it 'association is destroyed in Friendship model' do
      user1 = create(:user)
      user2 = create(:user)
      FriendRequest.create(sender_id: user1.id, receiver_id: user2.id)
      expect { FriendRequest.first.destroy }.to(change { FriendRequest.count })
    end
  end

  context 'when friend is removed' do
    it 'association is destroyed in Friendship model' do
      user1 = create(:user)
      user2 = create(:user)
      FriendRequest.create(sender_id: user1.id, receiver_id: user2.id)
      frienship = Friendship.new
      frienship.metadata = FriendRequest.first
      frienship.save
      expect { FriendRequest.first.destroy }.to(change { Friendship.count })
    end

    it 'association is destroyed in FriendRequest model' do
      user1 = create(:user)
      user2 = create(:user)
      FriendRequest.create(sender_id: user1.id, receiver_id: user2.id)
      frienship = Friendship.new
      frienship.metadata = FriendRequest.first
      frienship.save
      expect { FriendRequest.first.destroy }.to(change { FriendRequest.count })
    end
  end
end
