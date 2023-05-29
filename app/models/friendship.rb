class Friendship < ApplicationRecord
    belongs_to :metadata, class_name: "FriendRequest" 
    
    def self.existing(current_user)
       all_connections =  FriendRequest.joins("INNER JOIN friendships ON friend_requests.id = friendships.metadata_id").where("sender_id=? OR receiver_id=?",current_user.id,current_user.id)
       connections_with_current_user = all_connections.where('sender_id=?',current_user.id).or(all_connections.where('receiver_id=?',current_user.id)).includes(:sender,:receiver)
       friends = connections_with_current_user.map{|connection| [connection.sender,connection.receiver]}.flatten.reject do |user|
        user == current_user
       end
    end
end