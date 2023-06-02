# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  context 'user 1 sends friend request to user 2' do
    it 'builds association between FriendRequest and User' do
      user1 = create(:user)
      user2 = create(:user)
      expect(FriendRequest.new(sender_id: user1.id, receiver_id: user2.id).valid?).to be true
    end

    it 'so that user1 is on the sending end' do
      user1 = create(:user)
      user2 = create(:user)
      FriendRequest.create(sender_id: user1.id, receiver_id: user2.id)
      expect(user1.sent_requests.first.sender).to eq(user1)
    end

    it 'so that user2 is on the receiving end' do
      user1 = create(:user)
      user2 = create(:user)
      FriendRequest.create(sender_id: user1.id, receiver_id: user2.id)
      expect(user1.sent_requests.first.receiver).to eq(user2)
    end
  end

  context 'user1 sends friend request to user2 and user3' do
    it 'so that user1 is able to send multiple requests' do
      user1 = create(:user)
      user2 = create(:user)
      create(:user)
      FriendRequest.create(sender_id: user1.id, receiver_id: user2.id)
      expect(user1.sent_requests.first.sender).to eq(user1)
      expect(user1.sent_requests.last.sender).to eq(user1)
    end
  end

  context 'user1 receives friend request from user2 and user3' do
    it 'so that user1 is able to recieve multiple requests' do
      user1 = create(:user)
      user2 = create(:user)
      user3 = create(:user)
      FriendRequest.create(sender_id: user2.id, receiver_id: user1.id)
      FriendRequest.create(sender_id: user3.id, receiver_id: user1.id)

      expect(user1.received_requests.first.sender).to eq(user2)
      expect(user1.received_requests.last.sender).to eq(user3)
    end
  end
end
