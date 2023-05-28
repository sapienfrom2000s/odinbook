class Friendship < ApplicationRecord
    belongs_to :metadata, class_name: "FriendRequest"
    
    def self.friends(current_user)
        # all_connections = Friendship.includes(:metadata).where()
    end
end