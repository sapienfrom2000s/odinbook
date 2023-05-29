class Friendship < ApplicationRecord
    belongs_to :metadata, class_name: "FriendRequest" 
    
    def self.existing(current_user)
        # all_connections = Friendship.includes(:metadata).where()
    end
end