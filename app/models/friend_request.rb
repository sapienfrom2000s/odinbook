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

    def self.sent(current_user)
        anti_join = FriendRequest.joins("LEFT JOIN friendships ON friend_requests.id = friendships.metadata_id").where("friendships.metadata_id IS NULL")
        connections = anti_join.where(sender_id: current_user.id)
    end
end    