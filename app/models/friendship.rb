class Friendship < ApplicationRecord
    belongs_to :metadata, class_name: "FriendRequest" 
end