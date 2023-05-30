class Friendship < ApplicationRecord
    belongs_to :metadata, class_name: "FriendRequest" 
    
    def self.connections(current_user)
       all_connections =  FriendRequest.joins("INNER JOIN friendships ON friend_requests.id = friendships.metadata_id").where("sender_id=? OR receiver_id=?",current_user.id,current_user.id)
       connections_with_current_user = all_connections.where('sender_id=?',current_user.id).or(all_connections.where('receiver_id=?',current_user.id)).includes(:sender,:receiver)
    end

    def self.friend(connection, current_user)
        return connection.receiver.username unless connection.receiver.id == current_user.id
        connection.sender.username
    end
end