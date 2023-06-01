class FriendRequest < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :receiver, class_name: 'User'

    has_one :acceptance, foreign_key: :metadata, class_name: 'Friendship', dependent: :destroy

    validate :sender_and_receiver_shouldnt_be_the_same

    def sender_and_receiver_shouldnt_be_the_same
        if self.sender_id == self.receiver_id
            errors.add(:base, "sender and receiver can't be the same")
        end
    end

    def self.other_end_is_current_user?(connection, current_user)
        @connection.sender == current_user || @connection.receiver == current_user
    end
end    