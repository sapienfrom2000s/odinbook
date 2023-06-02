# frozen_string_literal: true

class FriendRequest < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  has_one :acceptance, foreign_key: :metadata, class_name: 'Friendship', dependent: :destroy

  validate :sender_and_receiver_shouldnt_be_the_same

  def sender_and_receiver_shouldnt_be_the_same
    return unless sender_id == receiver_id

    errors.add(:base, "sender and receiver can't be the same")
  end
end
