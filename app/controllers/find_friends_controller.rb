require 'pry-byebug'
class FindFriendsController < ApplicationController
    before_action :authenticate_user!

    def index
        @potential_friends = User.find_friends(current_user)
        @sent_requests = User.sent_requests(current_user)
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

    def destroy
        @connection = FriendRequest.find(friend_request_params[:id])
        destroyed = @connection.destroy if @connection.sender == current_user || @connection.receiver == current_user
    
        respond_to do |format|
          if destroyed
            format.html { redirect_to find_friends_url, notice: "Friend request was retracted." }
            format.json { head :no_content }
          else
            format.html { render :index, notice: "Unable to retract the request" }
          end
        end
    end

    def potential_friend_params
        params.require(:potential_friend).permit(:receiver_id)
    end

    def friend_request_params
        params.require(:friend_request).permit(:id)
    end
end
