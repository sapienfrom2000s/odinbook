class FriendRequest < ApplicationRecord
    belongs_to :sender, class_name: 'User'
    belongs_to :receiver, class_name: 'User'

    validate :sender_and_receiver_shouldnt_be_the_same

    def sender_and_receiver_shouldnt_be_the_same
        if self.sender_id == self.receiver_id
            errors.add(:base, "sender and receiver can't be the same")
        end
    end
end
