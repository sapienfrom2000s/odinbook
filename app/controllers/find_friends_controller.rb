# frozen_string_literal: true
class FindFriendsController < ApplicationController
  before_action :authenticate_user!

  def index
    @potential_friends = User.find_friends(current_user)
    @sent_requests = User.sent_friendrequests(current_user)
  end

  def create
    @friendrequest = FriendRequest.new
    @friendrequest.sender = current_user
    @friendrequest.receiver = User.find(potential_friend_params[:receiver_id])

    respond_to do |format|
      if @friendrequest.save
        @request = User.sent_friendrequests(current_user).find_by(receiver_id: potential_friend_params[:receiver_id])
        format.turbo_stream{ flash.now[:notice] = "Friend Request successfully sent" }
        format.html { redirect_to find_friends_url, notice: 'Friend Request was successfully sent.' }
      end
    end
  end

  def destroy
    @connection = FriendRequest.find(friend_request_params[:id])
    @potential_friend = @connection.receiver
    destroyed = @connection.destroy if @connection.sender == current_user || @connection.receiver == current_user

    respond_to do |format|
      if destroyed
        format.turbo_stream{ flash.now[:notice] = "Friend request was retracted." }        
        format.html { redirect_to find_friends_url, notice: 'Friend request was retracted.' }
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
