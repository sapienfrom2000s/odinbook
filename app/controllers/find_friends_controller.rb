class FindFriendsController < ApplicationController
    def index
        @potential_friends = User.find_friends(current_user)
    end

    def create
        @friendrequest = FriendRequest.new
        @friendrequest.sender = current_user
        @friendrequest.receiver = User.find(potential_friend_params[:receiver_id])
        
        respond_to do |format|
            if @friendrequest.save
                format.html { redirect_to find_friends_url, notice: "Friend Request was successfully sent." }
                format.json { head :no_content }
            else
                format.html { redirect_to find_friends_url, notice: "Unable to send Friend Request." }
                format.json { head :unable_to_send_request }              
            end    
        end
    end

    def potential_friend_params
        params.require(:potential_friend).permit(:receiver_id)
    end
end
